import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/power_visuals.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../providers.dart';
import '../appliances/my_appliances_screen.dart';
import '../battery_needed/battery_needed_screen.dart';
import '../batteries/battery_profiles_screen.dart';
import '../runtime/runtime_calculator_screen.dart';
import '../settings/settings_screen.dart';
import '../setups/saved_setups_screen.dart';
import '../tools/tools_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  void _push(BuildContext context, Widget page) =>
      Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => page));
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context), theme = Theme.of(context);
    final saved = ref.watch(savedSetupsProvider).asData?.value;
    return PowerBackdrop(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
            children: [
              Row(
                children: [
                  const PowerMark(size: 47),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PowerLeft',
                          style: theme.textTheme.headlineMedium!.copyWith(
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          l.designTagline,
                          style: theme.textTheme.bodySmall!.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: l.settingsTitle,
                    onPressed: () => _push(context, const SettingsScreen()),
                    icon: const Icon(Icons.settings_outlined),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              LayoutBuilder(
                builder: (context, constraints) {
                  final cards = [
                    _HomeCalculationCard(
                      interactionKey: const ValueKey('home-runtime-card'),
                      title: l.designRuntimeQuestion,
                      body: l.designRuntimeBody,
                      cta: l.homeRuntimeCta,
                      onTap: () =>
                          _push(context, const RuntimeCalculatorScreen()),
                    ),
                    _HomeCalculationCard(
                      interactionKey: const ValueKey('home-needed-card'),
                      title: l.designNeededQuestion,
                      body: l.designNeededBody,
                      cta: l.homeNeededCta,
                      plus: true,
                      onTap: () => _push(context, const BatteryNeededScreen()),
                    ),
                  ];
                  if (constraints.maxWidth < 320 ||
                      MediaQuery.textScalerOf(context).scale(16) > 21) {
                    return Column(
                      children: [
                        cards[0],
                        const SizedBox(height: 12),
                        cards[1],
                      ],
                    );
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: cards[0]),
                      const SizedBox(width: 12),
                      Expanded(child: cards[1]),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              _HomeMenu(
                icon: Icons.bookmark_border_rounded,
                title: l.homeSavedTitle,
                body: l.designSavedHint,
                badge: saved == null ? null : '${saved.length}',
                onTap: () => _push(context, const SavedSetupsScreen()),
              ),
              const SizedBox(height: 9),
              _HomeMenu(
                icon: Icons.power_outlined,
                title: l.appliancesTitle,
                body: l.designAppliancesHint,
                onTap: () => _push(context, const MyAppliancesScreen()),
              ),
              const SizedBox(height: 9),
              _HomeMenu(
                icon: Icons.battery_charging_full_rounded,
                title: l.batteryProfilesTitle,
                body: l.designBatteriesHint,
                onTap: () => _push(context, const BatteryProfilesScreen()),
              ),
              const SizedBox(height: 9),
              _HomeMenu(
                icon: Icons.tune_rounded,
                title: l.toolsTitle,
                body: l.designToolsHint,
                onTap: () => _push(context, const ToolsScreen()),
              ),
              const SizedBox(height: 9),
              _HomeMenu(
                icon: Icons.settings_outlined,
                title: l.settingsTitle,
                body: l.settingsDefaults,
                onTap: () => _push(context, const SettingsScreen()),
              ),
              const SizedBox(height: 20),
              AppCard(
                padding: EdgeInsets.zero,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 92),
                    child: Stack(
                      children: [
                        const Positioned.fill(
                          child: PowerLandscape(height: 92),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 106, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l.designCampTitle,
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                l.designCampBody,
                                style: theme.textTheme.bodySmall!.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeCalculationCard extends StatelessWidget {
  const _HomeCalculationCard({
    required this.interactionKey,
    required this.title,
    required this.body,
    required this.cta,
    required this.onTap,
    this.plus = false,
  });
  final Key interactionKey;
  final String title, body, cta;
  final VoidCallback onTap;
  final bool plus;
  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: '$title. $cta',
    child: AppCard(
      padding: EdgeInsets.zero,
      child: InkWell(
        key: interactionKey,
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 228),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PowerMark(size: 58, plus: plus, tile: false),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(fontSize: 18, height: 1.4),
                ),
                const SizedBox(height: 8),
                Text(
                  body,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        cta,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        size: 17,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class _HomeMenu extends StatelessWidget {
  const _HomeMenu({
    required this.icon,
    required this.title,
    required this.body,
    required this.onTap,
    this.badge,
  });
  final IconData icon;
  final String title, body;
  final String? badge;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => AppCard(
    padding: EdgeInsets.zero,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          children: [
            PowerIconTile(icon: icon),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 2),
                  Text(
                    body,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (badge != null) ...[
              const SizedBox(width: 8),
              Text(badge!, style: Theme.of(context).textTheme.bodySmall),
            ],
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right_rounded,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              size: 20,
            ),
          ],
        ),
      ),
    ),
  );
}
