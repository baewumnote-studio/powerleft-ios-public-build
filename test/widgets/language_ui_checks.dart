import 'package:drift/drift.dart' show DatabaseConnection;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:powerleft/app/powerleft_app.dart';
import 'package:powerleft/core/constants/app_environment.dart';
import 'package:powerleft/data/db/app_database.dart';
import 'package:powerleft/features/home/home_screen.dart';
import 'package:powerleft/features/onboarding/onboarding_screen.dart';
import 'package:powerleft/features/settings/settings_screen.dart';
import 'package:powerleft/l10n/app_languages.dart';
import 'package:powerleft/l10n/generated/app_localizations.dart';
import 'package:powerleft/providers.dart';
import 'package:powerleft/services/privacy_service.dart';
import 'package:powerleft/services/settings_service.dart';
import '../support/preferences_test_support.dart';

class HostPrivacy extends PrivacyService {
  @override
  Future<bool> privacyOptionsRequired() async => false;
}

Future<void> runAppCheck(
  WidgetTester tester,
  Map<String, Object> preferences,
  Future<void> Function(AppDatabase) body, {
  Size size = const Size(390, 844),
  double scale = 1,
}) async {
  expect(AppEnvironment.adsDisabledForTesting, isTrue);
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  tester.binding.platformDispatcher.localesTestValue = const [Locale('ko')];
  tester.binding.platformDispatcher.textScaleFactorTestValue = scale;
  setInitialPreferences(preferences);
  final db = AppDatabase(
    DatabaseConnection(
      NativeDatabase.memory(),
      closeStreamsSynchronously: true,
    ),
  );
  try {
    await mountApp(tester, db);
    await body(db);
    expect(tester.takeException(), isNull);
  } finally {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
    await db.close();
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
    tester.binding.platformDispatcher.clearLocalesTestValue();
    tester.binding.platformDispatcher.clearTextScaleFactorTestValue();
  }
}

Future<void> mountApp(WidgetTester tester, AppDatabase db) async {
  final settings = await SettingsService.create();
  await tester.pumpWidget(
    ProviderScope(
      key: UniqueKey(),
      overrides: [
        settingsServiceProvider.overrideWithValue(settings),
        databaseProvider.overrideWithValue(db),
        privacyServiceProvider.overrideWithValue(HostPrivacy()),
      ],
      child: const PowerLeftApp(),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> openSettings(WidgetTester tester) async {
  Navigator.of(
    tester.element(find.byType(HomeScreen)),
  ).push(MaterialPageRoute<void>(builder: (_) => const SettingsScreen()));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const ValueKey('settings-language')));
  await tester.pumpAndSettle();
}

Future<void> choose(WidgetTester tester, String code) async {
  final option = find.byKey(ValueKey('language-option-$code'));
  await tester.ensureVisible(option);
  await tester.tap(option);
  await tester.pumpAndSettle();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    final loader = FontLoader('PowerLeftSans');
    loader.addFont(rootBundle.load('assets/fonts/NotoSansKR.ttf'));
    await loader.load();
    final japanese = FontLoader('PowerLeftJapanese');
    japanese.addFont(rootBundle.load('assets/fonts/NotoSansJP.ttf'));
    await japanese.load();
  });

  testWidgets(
    'all first-run translations fit a small display with large text',
    (tester) async {
      await runAppCheck(
        tester,
        {},
        (db) async {
          for (final code in AppLanguages.nativeNames.keys) {
            await tester.tap(find.byKey(const ValueKey('onboarding-language')));
            await tester.pumpAndSettle();
            await choose(tester, code);
            expect(
              Localizations.localeOf(
                tester.element(find.byType(OnboardingScreen)),
              ).languageCode,
              code,
            );
            expect(tester.takeException(), isNull);
          }
        },
        size: const Size(340, 568),
        scale: 1.5,
      );
    },
  );

  testWidgets(
    'six native-name options switch existing routes and survive app recreation',
    (tester) async {
      await runAppCheck(tester, {'hasCompletedOnboarding': true}, (db) async {
        expect(
          AppLanguages.nativeNames.keys.toSet(),
          AppLocalizations.supportedLocales
              .map((locale) => locale.languageCode)
              .toSet(),
        );
        for (final choice in AppLanguages.nativeNames.entries) {
          await openSettings(tester);
          expect(find.text(choice.value), findsOneWidget);
          await choose(tester, choice.key);
          final context = tester.element(find.byType(SettingsScreen));
          expect(Localizations.localeOf(context).languageCode, choice.key);
          expect(
            find.text(AppLocalizations.of(context).settingsLanguage),
            findsOneWidget,
          );
          await tester.tap(find.byType(BackButton));
          await tester.pumpAndSettle();
          expect(
            Localizations.localeOf(
              tester.element(find.byType(HomeScreen)),
            ).languageCode,
            choice.key,
          );
          await mountApp(tester, db);
          expect(
            Localizations.localeOf(
              tester.element(find.byType(HomeScreen)),
            ).languageCode,
            choice.key,
          );
        }
      });
    },
  );

  testWidgets(
    'language picker remains scrollable with 150 percent text on a small screen',
    (tester) async {
      await runAppCheck(
        tester,
        {'hasCompletedOnboarding': true},
        (db) async {
          await openSettings(tester);
          await choose(tester, 'fr');
          final context = tester.element(find.byType(SettingsScreen));
          expect(Localizations.localeOf(context).languageCode, 'fr');
          expect(MediaQuery.textScalerOf(context).scale(16), 24);
          await tester.tap(find.byKey(const ValueKey('settings-language')));
          await tester.pumpAndSettle();
          await choose(tester, 'es');
          expect(
            Localizations.localeOf(
              tester.element(find.byType(SettingsScreen)),
            ).languageCode,
            'es',
          );
        },
        size: const Size(340, 568),
        scale: 1.5,
      );
    },
  );

  testWidgets(
    'first-run language choice overrides device and automatic mode restores it with English fallback',
    (tester) async {
      await runAppCheck(tester, {}, (db) async {
        await tester.tap(find.byKey(const ValueKey('onboarding-language')));
        await tester.pumpAndSettle();
        await choose(tester, 'ja');
        final context = tester.element(find.byType(OnboardingScreen));
        expect(Localizations.localeOf(context).languageCode, 'ja');
        final l = AppLocalizations.of(context);
        await tester.tap(find.text(l.onboardingNext));
        await tester.pumpAndSettle();
        await tester.tap(find.text(l.onboardingStart));
        await tester.pumpAndSettle();
        tester.binding.platformDispatcher.localesTestValue = const [
          Locale('pt', 'BR'),
        ];
        await tester.pumpAndSettle();
        expect(
          Localizations.localeOf(
            tester.element(find.byType(HomeScreen)),
          ).languageCode,
          'ja',
        );
        await openSettings(tester);
        await choose(tester, 'system');
        expect(
          Localizations.localeOf(
            tester.element(find.byType(SettingsScreen)),
          ).languageCode,
          'en',
        );
        expect((await SettingsService.create()).languageCode, isNull);
        tester.binding.platformDispatcher.localesTestValue = const [
          Locale('ko'),
        ];
        await tester.pumpAndSettle();
        expect(
          Localizations.localeOf(
            tester.element(find.byType(SettingsScreen)),
          ).languageCode,
          'ko',
        );
      });
    },
  );
}
