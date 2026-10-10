import 'package:flutter_test/flutter_test.dart';
import 'package:powerleft/services/settings_service.dart';
import '../support/preferences_test_support.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'language defaults to device settings and ignores unsupported stored values',
    () async {
      setInitialPreferences({});
      expect((await SettingsService.create()).languageCode, isNull);
      setInitialPreferences({'languageCode': 'pt'});
      expect((await SettingsService.create()).languageCode, isNull);
    },
  );

  test('all six language choices survive a new preferences service', () async {
    setInitialPreferences({});
    final service = await SettingsService.create();
    for (final code in ['en', 'ko', 'ja', 'de', 'fr', 'es']) {
      await service.setLanguageCode(code);
      expect((await SettingsService.create()).languageCode, code);
    }
    await service.setLanguageCode(null);
    expect((await SettingsService.create()).languageCode, isNull);
  });

  test(
    'unsupported language is rejected without changing the existing choice',
    () async {
      setInitialPreferences({'languageCode': 'ja'});
      final service = await SettingsService.create();
      await expectLater(service.setLanguageCode('pt'), throwsArgumentError);
      expect((await SettingsService.create()).languageCode, 'ja');
    },
  );

  test(
    'resetting calculation defaults preserves the selected language',
    () async {
      setInitialPreferences({
        'languageCode': 'fr',
        'defaultReserveFloorPercent': 25.0,
      });
      final service = await SettingsService.create();
      await service.resetDefaults();
      expect(service.languageCode, 'fr');
      expect(service.defaultReserveFloorPercent, 10);
    },
  );

  String todayKey() {
    final d = DateTime.now();
    return '${d.year.toString().padLeft(4, '0')}-'
        '${d.month.toString().padLeft(2, '0')}-'
        '${d.day.toString().padLeft(2, '0')}';
  }

  test('first session shows no ads even after four calculations', () async {
    setInitialPreferences({});
    final service = await SettingsService.create();
    await service.beginSession();

    for (var i = 0; i < 4; i++) {
      await service.registerMeaningfulCalculation();
    }
    expect(service.launchCount, 1);
    expect(service.isAdFrequencyEligible, isFalse);
  });

  test(
    'second session can become eligible after four accumulated actions',
    () async {
      setInitialPreferences({});
      final service = await SettingsService.create();

      await service.beginSession();
      for (var i = 0; i < 4; i++) {
        await service.registerMeaningfulCalculation();
      }
      await service.beginSession();

      expect(service.launchCount, 2);
      expect(service.isAdFrequencyEligible, isTrue);
    },
  );

  test('same session is not eligible after an ad has shown', () async {
    setInitialPreferences({
      'launchCount': 1,
      'lifetimeCompletedCalculations': 4,
      'meaningfulActionCountSinceAd': 4,
    });
    final service = await SettingsService.create();
    await service.beginSession();

    expect(service.isAdFrequencyEligible, isTrue);
    await service.markAdShown();
    expect(service.isAdFrequencyEligible, isFalse);
    expect(service.sessionAdShown, isTrue);
  });

  test('20 minute interval blocks a second opportunity', () async {
    final tenMinutesAgo = DateTime.now()
        .subtract(const Duration(minutes: 10))
        .millisecondsSinceEpoch;

    setInitialPreferences({
      'launchCount': 1,
      'lifetimeCompletedCalculations': 8,
      'meaningfulActionCountSinceAd': 4,
      'lastInterstitialAtEpochMs': tenMinutesAgo,
      'sessionAdShown': false,
      'adsShownToday': 1,
      'lastAdLocalDate': todayKey(),
    });
    final service = await SettingsService.create();
    await service.beginSession();

    expect(service.isAdFrequencyEligible, isFalse);
  });

  test('opportunity is eligible after the 20 minute interval', () async {
    final twentyFiveMinutesAgo = DateTime.now()
        .subtract(const Duration(minutes: 25))
        .millisecondsSinceEpoch;

    setInitialPreferences({
      'launchCount': 1,
      'lifetimeCompletedCalculations': 8,
      'meaningfulActionCountSinceAd': 4,
      'lastInterstitialAtEpochMs': twentyFiveMinutesAgo,
      'sessionAdShown': false,
      'adsShownToday': 1,
      'lastAdLocalDate': todayKey(),
    });
    final service = await SettingsService.create();
    await service.beginSession();

    expect(service.isAdFrequencyEligible, isTrue);
  });

  test('daily cap of two blocks ads', () async {
    setInitialPreferences({
      'launchCount': 1,
      'lifetimeCompletedCalculations': 12,
      'meaningfulActionCountSinceAd': 4,
      'sessionAdShown': false,
      'adsShownToday': 2,
      'lastAdLocalDate': todayKey(),
    });
    final service = await SettingsService.create();
    await service.beginSession();

    expect(service.isAdFrequencyEligible, isFalse);
  });

  test('stale previous-day daily count does not block current day', () async {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    final yesterdayKey =
        '${yesterday.year.toString().padLeft(4, '0')}-'
        '${yesterday.month.toString().padLeft(2, '0')}-'
        '${yesterday.day.toString().padLeft(2, '0')}';

    setInitialPreferences({
      'launchCount': 1,
      'lifetimeCompletedCalculations': 12,
      'meaningfulActionCountSinceAd': 4,
      'sessionAdShown': false,
      'adsShownToday': 2,
      'lastAdLocalDate': yesterdayKey,
    });
    final service = await SettingsService.create();
    await service.beginSession();

    expect(service.adsShownToday, 0);
    expect(service.isAdFrequencyEligible, isTrue);
  });

  test(
    'markAdShown resets meaningful count and increments today count',
    () async {
      setInitialPreferences({
        'launchCount': 1,
        'lifetimeCompletedCalculations': 8,
        'meaningfulActionCountSinceAd': 7,
        'sessionAdShown': false,
        'adsShownToday': 1,
        'lastAdLocalDate': todayKey(),
      });
      final service = await SettingsService.create();
      await service.beginSession();

      await service.markAdShown();

      expect(service.meaningfulActionCountSinceAd, 0);
      expect(service.adsShownToday, 2);
      expect(service.sessionAdShown, isTrue);
      expect(service.lastInterstitialAtEpochMs, isNotNull);
    },
  );

  test(
    'default reserve accepts full 0 to 50 range and clamps outside it',
    () async {
      setInitialPreferences({});
      final service = await SettingsService.create();

      await service.setDefaultReserveFloorPercent(50);
      expect(service.defaultReserveFloorPercent, 50);

      await service.setDefaultReserveFloorPercent(80);
      expect(service.defaultReserveFloorPercent, 50);

      await service.setDefaultReserveFloorPercent(-10);
      expect(service.defaultReserveFloorPercent, 0);
    },
  );
}
