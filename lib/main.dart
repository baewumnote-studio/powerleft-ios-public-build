import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/powerleft_app.dart';
import 'providers.dart';
import 'services/settings_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(() async* {
    yield LicenseEntryWithLineBreaks([
      'Noto Sans KR',
    ], await rootBundle.loadString('assets/fonts/OFL.txt'));
    yield LicenseEntryWithLineBreaks([
      'Noto Sans JP',
    ], await rootBundle.loadString('assets/fonts/OFL-JP.txt'));
  });
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final settings = await SettingsService.create();
  await settings.beginSession();

  runApp(
    ProviderScope(
      overrides: [settingsServiceProvider.overrideWithValue(settings)],
      child: const PowerLeftApp(),
    ),
  );
}
