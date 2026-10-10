import '../../core/widgets/setup_name_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/device_row.dart';
import '../../core/widgets/power_scaffold.dart';
import '../../data/repositories/setup_repository.dart';
import '../../domain/models/enums.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../providers.dart';
import '../battery_needed/battery_needed_screen.dart';
import '../runtime/runtime_calculator_screen.dart';

class SetupDetailScreen extends ConsumerWidget {
  const SetupDetailScreen({super.key, required this.setupId});

  final String setupId;

  Future<void> _rename(
    BuildContext context,
    WidgetRef ref,
    SavedSetupBundle bundle,
  ) async {
    final l = AppLocalizations.of(context);
    final value = await showSetupNameDialog(
      context,
      title: l.setupRenameTitle,
      initialName: bundle.setup.name,
    );
    if (!context.mounted || value == null) return;

    try {
      await ref.read(setupRepositoryProvider).rename(bundle.setup.id, value);
      ref.invalidate(savedSetupsProvider);
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l.setupRenameDone)));
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l.errorSaveData)));
    }
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final l = AppLocalizations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l.dialogDeleteTitle),
        content: Text(l.dialogDeleteBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l.commonDelete),
          ),
        ],
      ),
    );
    if (!context.mounted || ok != true) return;

    try {
      await ref.read(setupRepositoryProvider).delete(setupId);
      ref.invalidate(savedSetupsProvider);
      if (!context.mounted) return;
      Navigator.pop(context);
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l.errorSaveData)));
    }
  }

  void _edit(BuildContext context, WidgetRef ref, SavedSetupBundle bundle) {
    final setup = bundle.setup;
    final repo = ref.read(setupRepositoryProvider);
    final devices = repo.devicesFromItems(bundle.items);
    final connection = ConnectionTypeX.fromWire(setup.connectionType);

    final page = setup.mode == 'runtime'
        ? RuntimeCalculatorScreen(
            initialSetupId: setup.id,
            initialBatteryProfileId: setup.batteryProfileId,
            initialCapacityWh: setup.capacityWhSnapshot,
            initialChargePercent: setup.chargePercentSnapshot,
            initialConnection: connection,
            initialDevices: devices,
            initialReserveFloorPercent: setup.reserveFloorPercent,
            initialCustomEfficiency: setup.customEfficiency,
            initialMaxContinuousOutputW: setup.maxContinuousOutputW,
          )
        : BatteryNeededScreen(
            initialSetupId: setup.id,
            initialConnection: connection,
            initialDevices: devices,
            initialDesiredRuntimeHours: setup.desiredRuntimeHours,
          );

    Navigator.push(context, MaterialPageRoute<void>(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the setup list so this detail view rebuilds after an edit/save.
    ref.watch(savedSetupsProvider);
    final l = AppLocalizations.of(context);
    final repo = ref.watch(setupRepositoryProvider);

    return PowerScaffold(
      title: l.setupDetails,
      actions: [
        IconButton(
          tooltip: l.savedDelete,
          onPressed: () => _delete(context, ref),
          icon: const Icon(Icons.delete_outline),
        ),
      ],
      body: FutureBuilder<SavedSetupBundle?>(
        future: repo.getById(setupId),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final bundle = snapshot.data;
          if (bundle == null) {
            return Center(child: Text(l.setupNotFound));
          }

          final setup = bundle.setup;
          final devices = repo.devicesFromItems(bundle.items);

          return ListView(
            padding: const EdgeInsets.only(top: 8, bottom: 24),
            children: [
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            setup.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        IconButton(
                          tooltip: l.commonEdit,
                          onPressed: () => _rename(context, ref, bundle),
                          icon: const Icon(Icons.edit_outlined),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _Line(
                      label: l.setupConnection,
                      value: ConnectionTypeX.fromWire(
                        setup.connectionType,
                      ).shortLabel,
                    ),
                    if (setup.mode == 'runtime') ...[
                      _Line(
                        label: l.setupBattery,
                        value:
                            '${PowerFormatters.energy(setup.capacityWhSnapshot ?? 0, locale: Localizations.localeOf(context).toLanguageTag())} • '
                            '${(setup.chargePercentSnapshot ?? 0).round()}%',
                      ),
                    ] else ...[
                      _Line(
                        label: l.setupDesired,
                        value:
                            '${setup.desiredRuntimeHours == null ? '—' : PowerFormatters.number(setup.desiredRuntimeHours!, locale: Localizations.localeOf(context).toLanguageTag(), maxFractionDigits: 1)} ${l.commonHoursShort}',
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                l.setupDevices,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              AppCard(
                child: Column(
                  children: devices
                      .map((device) => DeviceRow(device: device))
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () => _edit(context, ref, bundle),
                child: Text(l.commonRecalculate),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
