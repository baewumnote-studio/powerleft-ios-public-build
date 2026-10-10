import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The same first-run UI path runs on the host and in native integration.
Future<void> runFirstRunSmoke(
  WidgetTester tester,
  Future<void> Function() launch,
) async {
  tester.binding.platformDispatcher.localeTestValue = const Locale('en');
  addTearDown(tester.binding.platformDispatcher.clearLocaleTestValue);
  Future<void> tapVisible(Finder finder) async {
    if (finder.evaluate().isEmpty) {
      await tester.scrollUntilVisible(
        finder,
        300,
        scrollable: find.byType(Scrollable).hitTestable().first,
      );
    }
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
  }

  await launch();
  await tester.pumpAndSettle();

  expect(find.text('Know how long your power will last.'), findsOneWidget);

  await tapVisible(find.text('Next'));
  await tester.pumpAndSettle();
  await tapVisible(find.text('Get Started'));
  await tester.pumpAndSettle();

  expect(find.byKey(const ValueKey('home-runtime-card')), findsOneWidget);
  await tapVisible(find.byKey(const ValueKey('home-runtime-card')));
  await tester.pumpAndSettle();

  await tester.enterText(
    find.byKey(const ValueKey('runtime-capacity-input')),
    '1000',
  );
  await tapVisible(find.byKey(const ValueKey('runtime-add-device')));
  await tester.pumpAndSettle();

  await tapVisible(find.byKey(const ValueKey('preset-wifi_router')));
  await tester.pumpAndSettle();
  await tapVisible(find.byKey(const ValueKey('device-editor-save')));
  await tester.pumpAndSettle();

  await tapVisible(find.byKey(const ValueKey('runtime-calculate')));
  await tester.pumpAndSettle();

  expect(find.byKey(const ValueKey('runtime-result-hero')), findsOneWidget);

  // Return to Home using normal back navigation twice.
  await tester.pageBack();
  await tester.pumpAndSettle();
  await tester.pageBack();
  await tester.pumpAndSettle();

  expect(find.byKey(const ValueKey('home-needed-card')), findsOneWidget);
  await tapVisible(find.byKey(const ValueKey('home-needed-card')));
  await tester.pumpAndSettle();

  await tapVisible(find.byKey(const ValueKey('needed-add-device')));
  await tester.pumpAndSettle();
  await tapVisible(find.byKey(const ValueKey('preset-wifi_router')));
  await tester.pumpAndSettle();
  await tapVisible(find.byKey(const ValueKey('device-editor-save')));
  await tester.pumpAndSettle();

  final hoursInput = find.byKey(const ValueKey('needed-hours-input'));
  if (hoursInput.evaluate().isEmpty) {
    await tester.scrollUntilVisible(
      hoursInput,
      -300,
      scrollable: find.byType(Scrollable).hitTestable().first,
    );
  }
  await tester.ensureVisible(hoursInput);
  await tester.enterText(hoursInput, '8');
  await tapVisible(find.byKey(const ValueKey('needed-calculate')));
  await tester.pumpAndSettle();

  expect(find.byKey(const ValueKey('needed-result-hero')), findsOneWidget);
}
