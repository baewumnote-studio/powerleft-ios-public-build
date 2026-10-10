// Copied to integration_test only by the screenshot workflow. No release code changes.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:powerleft/main.dart' as app;
import '../test/support/preferences_test_support.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  for (final language in ['en', 'ko', 'ja', 'de', 'fr', 'es']) {
    testWidgets('Store screenshots: $language', (tester) async {
      if (const bool.fromEnvironment('POWERLEFT_CAPTURE_HOST_CHECK')) {
        tester.view.physicalSize = const Size(1206, 2622);
        tester.view.devicePixelRatio = 3;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
      }
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpAndSettle();
      setInitialPreferences({
        'hasCompletedOnboarding': true,
        'languageCode': language,
        'themeMode': 'dark',
      });
      tester.binding.platformDispatcher.localeTestValue = Locale(language);
      addTearDown(tester.binding.platformDispatcher.clearLocaleTestValue);
      await app.main();
      await tester.pumpAndSettle();

      Future<void> tapKey(String key) async {
        final finder = find.byKey(ValueKey(key));
        if (finder.evaluate().isEmpty) {
          await tester.scrollUntilVisible(finder, 250,
            scrollable: find.byType(Scrollable).hitTestable().first);
        }
        await tester.ensureVisible(finder);
        await tester.pumpAndSettle();
        await tester.tap(finder);
        await tester.pumpAndSettle();
      }

      Future<void> screenshot(String name) async {
        FocusManager.instance.primaryFocus?.unfocus();
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        if (!const bool.fromEnvironment('POWERLEFT_CAPTURE_HOST_CHECK')) {
          await binding.takeScreenshot('$language/$name');
        }
      }

      Future<void> addDevice(String button, String preset) async {
        await tapKey(button);
        await tapKey('preset-$preset');
        await tapKey('device-editor-save');
      }

      expect(find.byKey(const ValueKey('home-runtime-card')), findsOneWidget);
      await screenshot('01_home');
      await tapKey('home-runtime-card');
      await tester.enterText(find.byKey(const ValueKey('runtime-capacity-input')), '1000');
      await addDevice('runtime-add-device', 'wifi_router');
      await addDevice('runtime-add-device', 'laptop');
      await tester.ensureVisible(find.byKey(const ValueKey('runtime-capacity-input')));
      await screenshot('02_runtime_input');
      await tapKey('runtime-calculate');
      expect(find.byKey(const ValueKey('runtime-result-hero')), findsOneWidget);
      await screenshot('03_runtime_result');
      await tester.pageBack();
      await tester.pumpAndSettle();
      await tester.pageBack();
      await tester.pumpAndSettle();
      await tapKey('home-needed-card');
      await addDevice('needed-add-device', 'wifi_router');
      await addDevice('needed-add-device', 'laptop');
      final hours = find.byKey(const ValueKey('needed-hours-input'));
      if (hours.evaluate().isEmpty) {
        await tester.scrollUntilVisible(hours, -250,
          scrollable: find.byType(Scrollable).hitTestable().first);
      }
      await tester.ensureVisible(hours);
      await tester.enterText(hours, '8');
      await tapKey('needed-calculate');
      expect(find.byKey(const ValueKey('needed-result-hero')), findsOneWidget);
      await screenshot('04_capacity_result');
    });
  }
}
