import '../../core/widgets/device_row.dart';
import '../../core/widgets/power_visuals.dart';
import '../../core/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/widgets/power_scaffold.dart';
import '../../data/models/appliance_preset.dart';
import '../../domain/models/device_input.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../l10n/localized_labels.dart';
import '../../providers.dart';
import 'device_editor_sheet.dart';

class ApplianceLibraryScreen extends ConsumerStatefulWidget {
  const ApplianceLibraryScreen({super.key});

  @override
  ConsumerState<ApplianceLibraryScreen> createState() =>
      _ApplianceLibraryScreenState();
}

class _ApplianceLibraryScreenState
    extends ConsumerState<ApplianceLibraryScreen> {
  String _query = '';
  String _category = 'all';

  Future<void> _pickPreset(AppliancePreset p) async {
    final l = AppLocalizations.of(context);
    final initial = DeviceInput(
      name: localizedDeviceName(l, p.nameKey),
      watts: p.midpointWatts,
      usagePattern: p.suggestedUsage,
      hasStartupSurge: p.hasStartupSurge,
      isMedicalRelated: p.isMedicalRelated,
      category: p.category,
      sourceApplianceId: p.id,
    );
    final edited = await DeviceEditorSheet.show(
      context,
      initial: initial,
      title: localizedDeviceName(l, p.nameKey),
      lockName: true,
      lockCategory: true,
    );
    if (edited != null && mounted) Navigator.pop(context, edited);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final presets = ref.watch(appliancePresetsProvider);
    final custom = ref.watch(customAppliancesProvider);
    final categories = [
      'all',
      'camping',
      'home_backup',
      'outdoor',
      'work',
      'high_draw',
    ];

    return PowerScaffold(
      title: l.runtimeAddDevice,
      body: ListView(
        children: [
          TextField(
            onChanged: (v) => setState(() => _query = v.trim().toLowerCase()),
            decoration: InputDecoration(
              hintText: l.deviceSearch,
              prefixIcon: const Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 42,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final c = categories[i];
                return ChoiceChip(
                  selected: _category == c,
                  label: Text(
                    c == 'all' ? l.categoryAll : localizedCategory(l, c),
                  ),
                  onSelected: (_) => setState(() => _category = c),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l.deviceConfirmValue,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 14),
          custom.when(
            data: (rows) {
              final matches = rows.where((row) {
                return _query.isEmpty ||
                    row.name.toLowerCase().contains(_query);
              }).toList();
              if (matches.isEmpty) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.appliancesTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  ...matches.map(
                    (row) => ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      title: Text(row.name),
                      subtitle: Text('${row.watts.round()} W'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () async {
                        final repo = ref.read(
                          customApplianceRepositoryProvider,
                        );
                        final edited = await DeviceEditorSheet.show(
                          context,
                          initial: repo.toDeviceInput(row),
                          title: row.name,
                        );
                        if (edited != null && context.mounted) {
                          Navigator.pop(context, edited);
                        }
                      },
                    ),
                  ),
                  const Divider(),
                ],
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
          ),
          presets.when(
            data: (items) {
              final filtered = items.where((p) {
                final name = localizedDeviceName(l, p.nameKey).toLowerCase();
                final categoryOk =
                    _category == 'all' || p.category == _category;
                final queryOk = _query.isEmpty || name.contains(_query);
                return categoryOk && queryOk;
              }).toList();
              return Column(
                children: filtered.map((p) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: AppCard(
                      padding: EdgeInsets.zero,
                      child: ListTile(
                        key: ValueKey('preset-${p.id}'),
                        leading: PowerIconTile(
                          icon: deviceIcon(p.id, p.category),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        title: Text(localizedDeviceName(l, p.nameKey)),
                        subtitle: Text(
                          '${l.deviceTypicalRange}: ${p.minWatts.round()}–${p.maxWatts.round()} W',
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => _pickPreset(p),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => Text(l.errorLoadData),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () async {
              final result = await DeviceEditorSheet.show(context);
              if (!context.mounted || result == null) return;
              await ref
                  .read(customApplianceRepositoryProvider)
                  .upsert(device: result);
              if (!context.mounted) return;
              Navigator.pop(context, result);
            },
            icon: const Icon(Icons.add),
            label: Text(l.deviceCustom),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
