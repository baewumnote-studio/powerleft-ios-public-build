import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/widgets/power_scaffold.dart';
import '../../core/widgets/power_visuals.dart';
import '../../core/widgets/app_card.dart';
import '../../core/utils/formatters.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../providers.dart';
import 'setup_detail_screen.dart';

class SavedSetupsScreen extends ConsumerWidget {
  const SavedSetupsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final saved = ref.watch(savedSetupsProvider);
    final repo = ref.watch(setupRepositoryProvider);

    return PowerScaffold(
      title: l.savedTitle,
      subtitle: l.designSavedHint,
      body: saved.when(
        data: (rows) {
          if (rows.isEmpty) {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const PowerIconTile(
                      icon: Icons.bookmarks_outlined,
                      size: 64,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l.savedEmptyTitle,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(l.savedEmptyAction, textAlign: TextAlign.center),
                  ],
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.only(top: 8, bottom: 24),
            itemCount: rows.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (_, index) {
              final row = rows[index];
              return Dismissible(
                key: ValueKey(row.id),
                direction: DismissDirection.endToStart,
                confirmDismiss: (_) async {
                  final confirmed = await showDialog<bool>(
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
                  if (!context.mounted || confirmed != true) return false;

                  try {
                    await repo.delete(row.id);
                    ref.invalidate(savedSetupsProvider);
                    return true;
                  } catch (_) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(l.errorSaveData)));
                    }
                    return false;
                  }
                },
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  color: Theme.of(context).colorScheme.errorContainer,
                  child: Icon(
                    Icons.delete_outline,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                child: AppCard(
                  padding: EdgeInsets.zero,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    leading: PowerIconTile(
                      icon: row.mode == 'runtime'
                          ? Icons.schedule_rounded
                          : Icons.battery_6_bar_rounded,
                    ),
                    title: Text(row.name),
                    subtitle: Text(
                      '${row.mode == 'runtime' ? l.setupModeRuntime : l.setupModeBattery} · ${row.capacityWhSnapshot != null ? PowerFormatters.energy(row.capacityWhSnapshot!, locale: Localizations.localeOf(context).toLanguageTag()) : '${row.desiredRuntimeHours} ${l.commonHoursShort}'}',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => SetupDetailScreen(setupId: row.id),
                      ),
                    ),
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
