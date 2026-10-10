import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data/db/app_database.dart';
import 'data/models/appliance_preset.dart';
import 'data/repositories/battery_profile_repository.dart';
import 'data/repositories/custom_appliance_repository.dart';
import 'data/repositories/setup_repository.dart';
import 'data/services/appliance_library_service.dart';
import 'domain/calculation/calculation_engine.dart';
import 'services/ad_service.dart';
import 'services/privacy_service.dart';
import 'services/settings_service.dart';

final settingsServiceProvider = Provider<SettingsService>(
  (ref) => throw StateError('SettingsService must be overridden in main().'),
);

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() {
    unawaited(db.close());
  });
  return db;
});

final batteryProfileRepositoryProvider = Provider<BatteryProfileRepository>(
  (ref) => BatteryProfileRepository(ref.watch(databaseProvider)),
);

final batteryProfilesProvider = StreamProvider<List<BatteryProfile>>(
  (ref) => ref.watch(batteryProfileRepositoryProvider).watchAll(),
);

final setupRepositoryProvider = Provider<SetupRepository>(
  (ref) => SetupRepository(ref.watch(databaseProvider)),
);

final customApplianceRepositoryProvider = Provider<CustomApplianceRepository>(
  (ref) => CustomApplianceRepository(ref.watch(databaseProvider)),
);

final calculationEngineProvider = Provider<CalculationEngine>(
  (ref) => const CalculationEngine(),
);

final applianceLibraryServiceProvider = Provider<ApplianceLibraryService>(
  (ref) => const ApplianceLibraryService(),
);

final appliancePresetsProvider = FutureProvider<List<AppliancePreset>>(
  (ref) => ref.watch(applianceLibraryServiceProvider).load(),
);

final savedSetupsProvider = StreamProvider<List<Setup>>(
  (ref) => ref.watch(setupRepositoryProvider).watchAll(),
);

final customAppliancesProvider = StreamProvider<List<CustomAppliance>>(
  (ref) => ref.watch(customApplianceRepositoryProvider).watchAll(),
);

final privacyServiceProvider = Provider<PrivacyService>(
  (ref) => PrivacyService(),
);

final adServiceProvider = Provider<AdService>((ref) {
  final service = AdService(
    settings: ref.watch(settingsServiceProvider),
    privacy: ref.watch(privacyServiceProvider),
  );
  ref.onDispose(service.dispose);
  return service;
});

final themeModeProvider = NotifierProvider<ThemeModeController, ThemeMode>(
  ThemeModeController.new,
);

class ThemeModeController extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ref.read(settingsServiceProvider).themeMode;

  Future<void> setMode(ThemeMode value) async {
    state = value;
    await ref.read(settingsServiceProvider).setThemeMode(value);
  }
}

final localeProvider = NotifierProvider<AppLocaleController, Locale?>(
  AppLocaleController.new,
);

class AppLocaleController extends Notifier<Locale?> {
  @override
  Locale? build() {
    final code = ref.read(settingsServiceProvider).languageCode;
    return code == null ? null : Locale(code);
  }

  Future<void> setLanguageCode(String? code) async {
    await ref.read(settingsServiceProvider).setLanguageCode(code);
    state = code == null ? null : Locale(code);
  }
}
