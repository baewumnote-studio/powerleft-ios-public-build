import '../../core/widgets/app_card.dart';
import '../../core/widgets/power_visuals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/power_scaffold.dart';
import '../../data/db/app_database.dart';
import '../../domain/models/enums.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../providers.dart';
import 'battery_profile_editor_sheet.dart';

class BatteryProfilesScreen extends ConsumerWidget {
  const BatteryProfilesScreen({super.key, this.selectionMode = false});

  final bool selectionMode;

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final repo = ref.read(batteryProfileRepositoryProvider);
    final draft = await BatteryProfileEditorSheet.show(context);
    if (!context.mounted || draft == null) return;

    try {
      await repo.upsert(
        name: draft.name,
        capacityWh: draft.capacityWh,
        connection: draft.connection,
        currentChargePercent: draft.chargePercent,
        maxContinuousOutputW: draft.maxContinuousOutputW,
      );
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).errorSaveData)),
      );
    }
  }

  Future<void> _edit(
    BuildContext context,
    WidgetRef ref,
    BatteryProfile row,
  ) async {
    final repo = ref.read(batteryProfileRepositoryProvider);
    final draft = await BatteryProfileEditorSheet.show(context, initial: row);
    if (!context.mounted || draft == null) return;

    try {
      await repo.upsert(
        id: row.id,
        name: draft.name,
        capacityWh: draft.capacityWh,
        connection: draft.connection,
        currentChargePercent: draft.chargePercent,
        maxContinuousOutputW: draft.maxContinuousOutputW,
      );
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).errorSaveData)),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final rows = ref.watch(batteryProfilesProvider);
    final repo = ref.watch(batteryProfileRepositoryProvider);

    return PowerScaffold(
      subtitle: l.designBatteriesHint,
      title: l.batteryProfilesTitle,
      actions: [
        IconButton(
          onPressed: () => _add(context, ref),
          icon: const Icon(Icons.add),
          tooltip: l.batteryProfileAdd,
        ),
      ],
      body: rows.when(
        data: (items) {
          if (items.isEmpty) {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const PowerMark(size: 56),
                    const SizedBox(height: 12),
                    Text(
                      l.batteryProfileEmpty,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l.batteryProfileEmptyBody,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 18),
                    FilledButton.icon(
                      onPressed: () => _add(context, ref),
                      icon: const Icon(Icons.add),
                      label: Text(l.batteryProfileAdd),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (_, i) {
              final row = items[i];
              return AppCard(
                padding: EdgeInsets.zero,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  leading: const PowerIconTile(
                    icon: Icons.battery_charging_full_rounded,
                  ),
                  title: Text(row.name),
                  subtitle: Text(
                    '${PowerFormatters.energy(row.capacityWh, locale: Localizations.localeOf(context).toLanguageTag())} • '
                    '${ConnectionTypeX.fromWire(row.defaultConnectionType).shortLabel} • '
                    '${row.currentChargePercent.round()}%',
                  ),
                  onTap: selectionMode
                      ? () => Navigator.pop(context, row)
                      : () => _edit(context, ref, row),
                  trailing: selectionMode
                      ? const Icon(Icons.chevron_right)
                      : PopupMenuButton<String>(
                          onSelected: (value) async {
                            if (value == 'edit') {
                              await _edit(context, ref, row);
                              return;
                            } else if (value == 'delete') {
                              final confirmed = await showDialog<bool>(
                                context: context,
                                builder: (dialogContext) => AlertDialog(
                                  title: Text(l.batteryProfileDelete),
                                  content: Text(l.dialogDeleteBody),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(dialogContext, false),
                                      child: Text(l.commonCancel),
                                    ),
                                    FilledButton(
                                      onPressed: () =>
                                          Navigator.pop(dialogContext, true),
                                      child: Text(l.commonDelete),
                                    ),
                                  ],
                                ),
                              );
                              if (!context.mounted || confirmed != true) {
                                return;
                              }
                              try {
                                await repo.delete(row.id);
                              } catch (_) {
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(l.errorSaveData)),
                                );
                              }
                            }
                          },
                          itemBuilder: (_) => [
                            PopupMenuItem(
                              value: 'edit',
                              child: Text(l.commonEdit),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Text(l.commonDelete),
                            ),
                          ],
                        ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l.errorLoadData)),
      ),
    );
  }
}
