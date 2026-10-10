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
import '../../l10n/localized_labels.dart';
import '../../providers.dart';

class RuntimeResultScreen extends ConsumerWidget {
  const RuntimeResultScreen({
    super.key,
    this.setupId,
    this.batteryProfileId,
    required this.result,
    required this.capacityWh,
    required this.chargePercent,
    required this.connection,
    required this.devices,
    required this.reserveFloorPercent,
    this.customEfficiency,
    this.maxContinuousOutputW,
  });

  final String? setupId;
  final String? batteryProfileId;
  final RuntimeEstimate result;
  final double capacityWh;
  final double chargePercent;
  final ConnectionType connection;
  final List<DeviceInput> devices;
  final double reserveFloorPercent;
  final double? customEfficiency;
  final double? maxContinuousOutputW;

  Future<void> _save(BuildContext context, WidgetRef ref) async {
    final l = AppLocalizations.of(context);
    String initialName = l.saveSetupDefaultRuntime;
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
            mode: 'runtime',
            connectionType: connection,
            batteryProfileId: batteryProfileId,
            devices: devices,
            capacityWh: capacityWh,
            chargePercent: chargePercent,
            reserveFloorPercent: reserveFloorPercent,
            customEfficiency: customEfficiency,
            maxContinuousOutputW: maxContinuousOutputW,
          );
      HapticFeedback.lightImpact();
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l.runtimeResultSaved)));
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l.runtimeSaveFailed)));
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
    return PowerScaffold(
      title: l.resultRuntimeTitle,
      compactTitle: true,
      body: ListView(
        padding: const EdgeInsets.only(top: 12, bottom: 24),
        children: [
          AppCard(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                const PowerMark(size: 37),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        PowerFormatters.energy(capacityWh, locale: locale),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        '${connection.shortLabel} · ${chargePercent.round()}% · ${PowerFormatters.watts(result.totalAverageLoadW, locale: locale, maxFractionDigits: 0)}',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            l.designCompareHint,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 13),
          Semantics(
            key: const ValueKey('runtime-result-hero'),
            liveRegion: true,
            label:
                '${l.resultRuntimeTitle}: ${localizedRuntime(l, result.typicalHours)}',
            child: ResultReveal(
              child: PowerComparison(
                gauges: true,
                labels: [l.resultConservative, l.resultTypical, l.resultBest],
                values: [
                  localizedRuntimeCard(l, result.conservativeHours),
                  localizedRuntimeCard(l, result.typicalHours),
                  localizedRuntimeCard(l, result.bestHours),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            child: Column(
              children: [
                PowerMetric(
                  icon: Icons.bolt_rounded,
                  label: l.resultTypicalEnergy,
                  value: PowerFormatters.energy(
                    result.typicalEffectiveEnergyWh,
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
                const Divider(height: 1),
                PowerMetric(
                  icon: Icons.show_chart_rounded,
                  label: l.resultRatedLoad,
                  value: PowerFormatters.watts(
                    result.totalRatedLoadW,
                    locale: locale,
                    maxFractionDigits: 0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          if (result.hasNoUsableEnergy) ...[
            WarningCard(
              title: l.warningReserveTitle,
              body: l.runtimeNoUsableEnergy,
              critical: true,
            ),
            const SizedBox(height: 10),
          ],
          if (result.outputLimitExceeded) ...[
            WarningCard(
              title: l.warningOutputTitle,
              body: l.warningOutputBody,
              critical: true,
            ),
            const SizedBox(height: 10),
          ],
          if (result.hasStartupSurge) ...[
            WarningCard(title: l.warningSurgeTitle, body: l.warningSurgeBody),
            const SizedBox(height: 10),
          ],
          if (result.isLowAcLoad) ...[
            WarningCard(
              title: l.warningLowLoadTitle,
              body: l.warningLowLoadBody,
            ),
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
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
            child: ExpansionTile(
              tilePadding: EdgeInsets.zero,
              title: Text(
                l.designDetails,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              children: [
                Text(
                  l.resultAboutEstimate,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 10),
                Text(
                  l.disclaimerShort,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 12),
              ],
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
