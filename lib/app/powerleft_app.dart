import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_environment.dart';
import '../features/home/home_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../l10n/generated/app_localizations.dart';
import '../providers.dart';
import 'theme/app_theme.dart';

class PowerLeftApp extends ConsumerStatefulWidget {
  const PowerLeftApp({super.key});

  @override
  ConsumerState<PowerLeftApp> createState() => _PowerLeftAppState();
}

class _PowerLeftAppState extends ConsumerState<PowerLeftApp> {
  @override
  void initState() {
    super.initState();
    if (AppEnvironment.adsDisabledForTesting) {
      return;
    }

    final settings = ref.read(settingsServiceProvider);
    final privacy = ref.read(privacyServiceProvider);
    final ads = ref.read(adServiceProvider);

    Future<void>(() async {
      if (settings.hasCompletedOnboarding) {
        await privacy.ensureConsentForAds();
      } else {
        // First launch: gather status now, but don't cover onboarding with a form.
        await privacy.updateConsentInfo();
      }
      await ads.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final settings = ref.watch(settingsServiceProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PowerLeft',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        ...AppLocalizations.supportedLocales.where(
          (supported) => supported.languageCode != 'en',
        ),
      ],
      home: settings.hasCompletedOnboarding
          ? const HomeScreen()
          : const OnboardingScreen(),
    );
  }
}
