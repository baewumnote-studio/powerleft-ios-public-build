import 'package:drift/drift.dart' show DatabaseConnection;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:powerleft/app/powerleft_app.dart';
import 'package:powerleft/data/db/app_database.dart';
import 'package:powerleft/data/models/appliance_preset.dart';
import 'package:powerleft/data/services/appliance_library_service.dart';
import 'package:powerleft/domain/models/device_input.dart';
import 'package:powerleft/domain/models/enums.dart';
import 'package:powerleft/features/battery_needed/battery_needed_screen.dart';
import 'package:powerleft/features/home/home_screen.dart';
import 'package:powerleft/l10n/generated/app_localizations.dart';
import 'package:powerleft/providers.dart';
import 'package:powerleft/services/settings_service.dart';
import '../support/preferences_test_support.dart';

late List<AppliancePreset> presets;

Future<void> withApp(
  WidgetTester tester,
  String locale,
  Size size,
  double scale,
  Future<void> Function(SettingsService, AppDatabase) body,
) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  tester.binding.platformDispatcher.localesTestValue = [Locale(locale)];
  tester.binding.platformDispatcher.textScaleFactorTestValue = scale;
  setInitialPreferences({'hasCompletedOnboarding': true});
  final settings = await SettingsService.create();
  await settings.beginSession();
  final db = AppDatabase(
    DatabaseConnection(
      NativeDatabase.memory(),
      closeStreamsSynchronously: true,
    ),
  );
  try {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          settingsServiceProvider.overrideWithValue(settings),
          databaseProvider.overrideWithValue(db),
          appliancePresetsProvider.overrideWith((ref) async => presets),
        ],
        child: const PowerLeftApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      MediaQuery.textScalerOf(
        tester.element(find.byType(HomeScreen)),
      ).scale(16),
      16 * scale,
    );
    await body(settings, db);
    expect(tester.takeException(), isNull);
  } finally {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
    await db.close();
    await tester.pump();
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
    tester.binding.platformDispatcher.clearLocalesTestValue();
    tester.binding.platformDispatcher.clearTextScaleFactorTestValue();
  }
}

Future<void> tapVisible(
  WidgetTester tester,
  Finder finder, {
  double scrollDelta = 300,
}) async {
  if (finder.evaluate().isEmpty) {
    await tester.scrollUntilVisible(
      finder,
      scrollDelta,
      scrollable: find.byType(Scrollable).first,
    );
  }
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
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
    presets = await const ApplianceLibraryService().load();
  });
  for (final locale in ['en', 'ko', 'ja', 'de', 'fr', 'es']) {
    for (final largeText in [false, true]) {
      testWidgets(
        '$locale: calculator flow at ${largeText ? "340px / 150% text" : "390px"}',
        (tester) async {
          await withApp(
            tester,
            locale,
            Size(largeText ? 340 : 390, 844),
            largeText ? 1.5 : 1,
            (settings, db) async {
              expect(settings.themeMode, ThemeMode.dark);
              await tapVisible(
                tester,
                find.byKey(const ValueKey('home-runtime-card')),
              );
              await tester.enterText(
                find.byKey(const ValueKey('runtime-capacity-input')),
                '1000',
              );
              await tapVisible(
                tester,
                find.byKey(const ValueKey('runtime-add-device')),
              );
              await tapVisible(
                tester,
                find.byKey(const ValueKey('preset-wifi_router')),
              );
              await tapVisible(
                tester,
                find.byKey(const ValueKey('device-editor-save')),
              );
              await tapVisible(
                tester,
                find.byKey(const ValueKey('runtime-calculate')),
              );
              expect(
                find.byKey(const ValueKey('runtime-result-hero')),
                findsOneWidget,
              );
              expect(tester.takeException(), isNull);
              await tester.tap(find.byType(BackButton));
              await tester.pumpAndSettle();
              await tester.tap(find.byType(BackButton));
              await tester.pumpAndSettle();
              await tapVisible(
                tester,
                find.byKey(const ValueKey('home-needed-card')),
              );
              await tapVisible(
                tester,
                find.byKey(const ValueKey('needed-add-device')),
              );
              await tapVisible(
                tester,
                find.byKey(const ValueKey('preset-wifi_router')),
              );
              await tapVisible(
                tester,
                find.byKey(const ValueKey('device-editor-save')),
              );
              await tapVisible(
                tester,
                find.byKey(const ValueKey('needed-hours-input')),
                scrollDelta: -300,
              );
              await tester.enterText(
                find.byKey(const ValueKey('needed-hours-input')),
                '8',
              );
              await tapVisible(
                tester,
                find.byKey(const ValueKey('needed-calculate')),
              );
              expect(
                find.byKey(const ValueKey('needed-result-hero')),
                findsOneWidget,
              );
            },
          );
        },
      );
    }
  }

  testWidgets(
    'duration stepper changes the real capacity calculation and saves it',
    (tester) async {
      await withApp(tester, 'ko', const Size(390, 844), 1, (
        settings,
        db,
      ) async {
        final container = ProviderScope.containerOf(
          tester.element(find.byType(HomeScreen)),
        );
        Navigator.of(tester.element(find.byType(HomeScreen))).push(
          MaterialPageRoute<void>(
            builder: (_) => const BatteryNeededScreen(
              initialDesiredRuntimeHours: 8,
              initialConnection: ConnectionType.ac,
              initialDevices: [
                DeviceInput(
                  name: 'LED',
                  watts: 10,
                  usagePattern: UsagePattern.alwaysOn,
                ),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();
        await tapVisible(
          tester,
          find.byKey(const ValueKey('needed-increment')),
        );
        final hours = tester
            .widget<TextField>(find.byKey(const ValueKey('needed-hours-input')))
            .controller!
            .text;
        expect(hours, '9');
        await tapVisible(
          tester,
          find.byKey(const ValueKey('needed-calculate')),
        );
        expect(find.text('90 Wh'), findsOneWidget);
        final l = AppLocalizations.of(
          tester.element(find.byKey(const ValueKey('needed-result-hero'))),
        );
        await tapVisible(tester, find.text(l.commonSaveSetup));
        await tester.enterText(find.byType(TextField), '9시간 조명');
        await tapVisible(tester, find.text(l.commonSave));
        final rows = await db.select(db.setups).get();
        expect(rows.single.name, '9시간 조명');
        expect(rows.single.desiredRuntimeHours, 9);
        await container
            .read(themeModeProvider.notifier)
            .setMode(ThemeMode.light);
        await tester.pumpAndSettle();
        expect(
          Theme.of(
            tester.element(find.byKey(const ValueKey('needed-result-hero'))),
          ).brightness,
          Brightness.light,
        );
      });
    },
  );
}
