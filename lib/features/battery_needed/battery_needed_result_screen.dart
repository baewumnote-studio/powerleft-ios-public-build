import '../../core/widgets/setup_name_dialog.dart';
import '../../core/widgets/power_visuals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/power_scaffold.dart';
import '../../core/widgets/result_reveal.dart';
import '../../core/widgets/warning_card.dart';
import '../../domain/models/calculation_results.dart';
import '../../domain/models/device_input.dart';
import '../../domain/models/enums.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../providers.dart';

class BatteryNeededResultScreen extends ConsumerWidget {
  const BatteryNeededResultScreen({
    super.key,
    this.setupId,
    required this.result,
    required this.desiredRuntimeHours,
    required this.connection,
    required this.devices,
  });

  final String? setupId;
  final BatteryNeededEstimate result;
  final double desiredRuntimeHours;
  final ConnectionType connection;
  final List<DeviceInput> devices;

  Future<void> _save(BuildContext context, WidgetRef ref) async {
    final l = AppLocalizations.of(context);
    String initialName = l.saveSetupDefaultBattery;
    if (setupId != null) {
      final existing = await ref
          .read(setupRepositoryProvider)
          .getById(setupId!);
      if (!context.mounted) return;
      initialName = existing?.setup.name ?? initialName;
    }
    final name = await showSetupNameDialog(
      context,
      title: l.dialogSaveSetupTitle,
      initialName: initialName,
    );
    if (!context.mounted || name == null) return;

    try {
      await ref
          .read(setupRepositoryProvider)
          .save(
            id: setupId,
            name: name,
            mode: 'batteryNeeded',
            connectionType: connection,
            devices: devices,
            desiredRuntimeHours: desiredRuntimeHours,
          );
      HapticFeedback.lightImpact();
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l.neededResultSaved)));
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l.errorSaveData)));
      }
    }
  }

  Future<void> _home(BuildContext context, WidgetRef ref) async {
    await ref.read(adServiceProvider).showIfEligible();
    if (!context.mounted) return;
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context),
        locale = Localizations.localeOf(context).toLanguageTag();
    final rounded = PowerFormatters.roundedPlanningCapacity(
      result.recommendedWh,
    );
    return PowerScaffold(
      title: l.neededResultTitle,
      compactTitle: true,
      body: ListView(
        padding: const EdgeInsets.only(top: 12, bottom: 24),
        children: [
          Semantics(
            key: const ValueKey('needed-result-hero'),
            liveRegion: true,
            label:
                '${l.neededResultTitle}: ${PowerFormatters.energy(rounded, locale: locale)}+',
            child: ResultReveal(
              child: AppCard(
                child: Column(
                  children: [
                    const PowerMark(size: 50, plus: true, tile: false),
                    const SizedBox(height: 10),
                    Text(
                      l.neededRecommended,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${PowerFormatters.energy(rounded, locale: locale)}+',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l.neededRoundedPlan,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          PowerComparison(
            labels: [l.neededMinimum, l.neededRecommended, l.neededComfortable],
            values: [
              PowerFormatters.energy(result.minimumWh, locale: locale),
              PowerFormatters.energy(result.recommendedWh, locale: locale),
              PowerFormatters.energy(result.comfortableWh, locale: locale),
            ],
          ),
          const SizedBox(height: 18),
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            child: Column(
              children: [
                PowerMetric(
                  icon: Icons.schedule_rounded,
                  label: l.neededDesiredRuntime,
                  value:
                      '${PowerFormatters.inputNumber(desiredRuntimeHours, locale: locale, maxFractionDigits: 2)} ${l.commonHoursShort}',
                ),
                const Divider(height: 1),
                PowerMetric(
                  icon: Icons.bolt_rounded,
                  label: l.neededEnergyDemand,
                  value: PowerFormatters.energy(
                    result.energyDemandWh,
                    locale: locale,
                  ),
                ),
                const Divider(height: 1),
                PowerMetric(
                  icon: Icons.bar_chart_rounded,
                  label: l.resultAverageLoad,
                  value: PowerFormatters.watts(
                    result.totalAverageLoadW,
                    locale: locale,
                    maxFractionDigits: 0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          if (result.hasStartupSurge) ...[
            WarningCard(title: l.warningSurgeTitle, body: l.warningSurgeBody),
            const SizedBox(height: 10),
          ],
          if (result.hasMedicalDevice) ...[
            WarningCard(
              title: l.warningCpapTitle,
              body: l.warningCpapBody,
              critical: true,
            ),
            const SizedBox(height: 10),
          ],
          Text(
            l.disclaimerFull,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () => _save(context, ref),
            icon: const Icon(Icons.bookmark_border_rounded),
            label: Text(
              setupId == null ? l.commonSaveSetup : l.commonUpdateSetup,
            ),
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.tune_rounded, size: 19),
            label: Text(l.resultAdjust),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => _home(context, ref),
            child: Text(l.commonBackHome),
          ),
        ],
      ),
    );
  }
}
