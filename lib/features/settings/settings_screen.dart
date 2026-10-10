import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/power_scaffold.dart';
import '../../core/widgets/power_visuals.dart';
import '../../l10n/app_languages.dart';
import '../../domain/models/enums.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../providers.dart';
import '../about/about_screen.dart';
import '../about/privacy_policy_screen.dart';
import 'language_picker.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late double _reserve;
  late ConnectionType _connection;

  @override
  void initState() {
    super.initState();
    final settings = ref.read(settingsServiceProvider);
    _reserve = settings.defaultReserveFloorPercent;
    _connection = ConnectionTypeX.fromWire(settings.defaultConnectionType);
  }

  Future<void> _reset() async {
    final settings = ref.read(settingsServiceProvider);
    await settings.resetDefaults();
    if (!mounted) return;
    setState(() {
      _reserve = 10;
      _connection = ConnectionType.ac;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).settingsResetDone)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = ref.watch(themeModeProvider);
    final settings = ref.watch(settingsServiceProvider);
    final privacy = ref.watch(privacyServiceProvider);
    final language = ref.watch(localeProvider)?.languageCode;
    final nativeName = AppLanguages
        .nativeNames[language ?? Localizations.localeOf(context).languageCode]!;

    return PowerScaffold(
      title: l.settingsTitle,
      body: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        children: [
          AppCard(
            padding: EdgeInsets.zero,
            child: ListTile(
              key: const ValueKey('settings-language'),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 12,
              ),
              leading: const PowerIconTile(icon: Icons.translate_rounded),
              title: Text(l.settingsLanguage),
              subtitle: Text(
                language == null
                    ? '${l.settingsLanguageSystem} · $nativeName'
                    : nativeName,
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => LanguagePicker.show(context, ref),
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.settingsTheme,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                if (MediaQuery.textScalerOf(context).scale(16) > 20 ||
                    MediaQuery.sizeOf(context).width < 360)
                  DropdownButtonFormField<ThemeMode>(
                    key: ValueKey(theme),
                    initialValue: theme,
                    items: [
                      DropdownMenuItem(
                        value: ThemeMode.system,
                        child: Text(l.settingsThemeSystem),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text(l.settingsThemeLight),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text(l.settingsThemeDark),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        ref.read(themeModeProvider.notifier).setMode(value);
                      }
                    },
                  )
                else
                  SegmentedButton<ThemeMode>(
                    segments: [
                      ButtonSegment(
                        value: ThemeMode.system,
                        label: Text(l.settingsThemeSystem),
                      ),
                      ButtonSegment(
                        value: ThemeMode.light,
                        label: Text(l.settingsThemeLight),
                      ),
                      ButtonSegment(
                        value: ThemeMode.dark,
                        label: Text(l.settingsThemeDark),
                      ),
                    ],
                    selected: {theme},
                    onSelectionChanged: (set) =>
                        ref.read(themeModeProvider.notifier).setMode(set.first),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.settingsDefaults,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                Text(l.settingsDefaultConnection),
                const SizedBox(height: 8),
                DropdownButtonFormField<ConnectionType>(
                  key: ValueKey(_connection),
                  initialValue: _connection,
                  items: ConnectionType.values
                      .map(
                        (c) => DropdownMenuItem(
                          value: c,
                          child: Text(c.shortLabel),
                        ),
                      )
                      .toList(),
                  onChanged: (value) async {
                    if (value == null) return;
                    setState(() => _connection = value);
                    await settings.setDefaultConnectionType(value.wireValue);
                  },
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(child: Text(l.settingsDefaultReserve)),
                    Text('${_reserve.round()}%'),
                  ],
                ),
                Semantics(
                  label: l.settingsDefaultReserve,
                  value: '${_reserve.round()}%',
                  child: Slider(
                    min: 0,
                    max: 50,
                    divisions: 50,
                    value: _reserve,
                    onChanged: (v) => setState(() => _reserve = v),
                    onChangeEnd: (v) =>
                        settings.setDefaultReserveFloorPercent(v),
                  ),
                ),
                Text(
                  l.settingsReserveHelp,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: _reset,
                  child: Text(l.settingsResetDefaults),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.settingsDataTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(l.settingsDeleteLocalDataBody),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                        title: Text(l.settingsDeleteLocalDataConfirm),
                        content: Text(l.settingsDeleteLocalDataBody),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.pop(dialogContext, false),
                            child: Text(l.commonCancel),
                          ),
                          FilledButton(
                            onPressed: () => Navigator.pop(dialogContext, true),
                            child: Text(l.commonDelete),
                          ),
                        ],
                      ),
                    );
                    if (!context.mounted || confirmed != true) return;
                    try {
                      await ref.read(databaseProvider).clearUserData();
                      ref.invalidate(savedSetupsProvider);
                      ref.invalidate(customAppliancesProvider);
                      ref.invalidate(batteryProfilesProvider);
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l.settingsDeleteLocalDataDone)),
                      );
                    } catch (_) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(l.errorSaveData)));
                    }
                  },
                  icon: const Icon(Icons.delete_sweep_outlined),
                  label: Text(l.settingsDeleteLocalData),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.settingsPrivacy,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(l.settingsPrivacyExplanation),
                const SizedBox(height: 10),
                FutureBuilder<bool>(
                  future: privacy.privacyOptionsRequired(),
                  builder: (context, snapshot) {
                    if (snapshot.data != true) {
                      return const SizedBox.shrink();
                    }
                    return OutlinedButton(
                      onPressed: () => privacy.showPrivacyOptions(),
                      child: Text(l.settingsPrivacyOptions),
                    );
                  },
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (_) => const PrivacyPolicyScreen(),
                    ),
                  ),
                  child: Text(l.settingsPrivacyPolicy),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.info_outline),
              title: Text(l.settingsAbout),
              subtitle: Text(l.settingsVersion),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (_) => const AboutScreen()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
