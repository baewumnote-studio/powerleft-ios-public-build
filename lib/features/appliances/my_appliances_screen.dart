import '../../core/widgets/app_card.dart';
import '../../core/widgets/power_visuals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/widgets/power_scaffold.dart';
import '../../data/repositories/custom_appliance_repository.dart';
import '../../domain/models/device_input.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../providers.dart';
import 'device_editor_sheet.dart';

class MyAppliancesScreen extends ConsumerWidget {
  const MyAppliancesScreen({super.key});

  Future<void> _saveDevice(
    BuildContext context,
    CustomApplianceRepository repo,
    DeviceInput device, {
    String? id,
  }) async {
    final l = AppLocalizations.of(context);
    try {
      await repo.upsert(id: id, device: device);
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l.errorSaveData)));
    }
  }

  Future<void> _deleteDevice(
    BuildContext context,
    CustomApplianceRepository repo,
    String id,
  ) async {
    final l = AppLocalizations.of(context);
    try {
      await repo.delete(id);
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l.errorSaveData)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final items = ref.watch(customAppliancesProvider);
    final repo = ref.watch(customApplianceRepositoryProvider);

    return PowerScaffold(
      subtitle: l.designAppliancesHint,
      title: l.appliancesTitle,
      actions: [
        IconButton(
          tooltip: l.myAppliancesAdd,
          onPressed: () async {
            final d = await DeviceEditorSheet.show(context);
            if (d != null && context.mounted) {
              await _saveDevice(context, repo, d);
            }
          },
          icon: const Icon(Icons.add),
        ),
      ],
      body: items.when(
        data: (rows) {
          if (rows.isEmpty) {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const PowerIconTile(icon: Icons.power_outlined, size: 64),
                    const SizedBox(height: 12),
                    Text(
                      l.appliancesEmptyTitle,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(l.appliancesEmptyBody, textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                    FilledButton.icon(
                      onPressed: () async {
                        final d = await DeviceEditorSheet.show(context);
                        if (d != null && context.mounted) {
                          await _saveDevice(context, repo, d);
                        }
                      },
                      icon: const Icon(Icons.add),
                      label: Text(l.myAppliancesAdd),
                    ),
                  ],
                ),
              ),
            );
          }
          return ListView.separated(
            itemCount: rows.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (_, i) {
              final row = rows[i];
              return AppCard(
                padding: EdgeInsets.zero,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  leading: const PowerIconTile(icon: Icons.power_outlined),
                  title: Text(row.name),
                  subtitle: Text('${row.watts.round()} W'),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) async {
                      if (value == 'edit') {
                        final d = await DeviceEditorSheet.show(
                          context,
                          initial: repo.toDeviceInput(row),
                          title: row.name,
                        );
                        if (d != null && context.mounted) {
                          await _saveDevice(context, repo, d, id: row.id);
                        }
                      } else if (value == 'delete') {
                        final ok = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(l.myAppliancesDeleteTitle),
                            content: Text(l.myAppliancesDeleteBody),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: Text(l.commonCancel),
                              ),
                              FilledButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: Text(l.commonDelete),
                              ),
                            ],
                          ),
                        );
                        if (ok == true && context.mounted) {
                          await _deleteDevice(context, repo, row.id);
                        }
                      }
                    },
                    itemBuilder: (_) => [
                      PopupMenuItem(value: 'edit', child: Text(l.commonEdit)),
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
