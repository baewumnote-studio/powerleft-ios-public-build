import 'package:drift/drift.dart' show DatabaseConnection;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:powerleft/app/powerleft_app.dart';
import 'package:powerleft/core/constants/app_environment.dart';
import 'package:powerleft/data/db/app_database.dart';
import 'package:powerleft/providers.dart';
import 'package:powerleft/services/settings_service.dart';

import '../support/first_run_smoke_flow.dart';
import '../support/preferences_test_support.dart';

void main() {
  testWidgets('host smoke: actual first-run calculator screens', (
    tester,
  ) async {
    expect(
      AppEnvironment.adsDisabledForTesting,
      isTrue,
      reason: 'Run with POWERLEFT_DISABLE_ADS_FOR_TESTING=true.',
    );
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(375, 667);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    setInitialPreferences({});
    final settings = await SettingsService.create();
    await settings.beginSession();
    final database = AppDatabase(
      DatabaseConnection(
        NativeDatabase.memory(),
        closeStreamsSynchronously: true,
      ),
    );
    var databaseClosed = false;
    Future<void> closeDatabase() async {
      if (databaseClosed) return;
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
      await database.close();
      databaseClosed = true;
    }

    addTearDown(closeDatabase);

    await runFirstRunSmoke(tester, () async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            settingsServiceProvider.overrideWithValue(settings),
            databaseProvider.overrideWithValue(database),
          ],
          child: const PowerLeftApp(),
        ),
      );
    });
    expect(tester.takeException(), isNull);
    await closeDatabase();
  });
}
