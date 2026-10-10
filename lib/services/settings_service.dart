import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_languages.dart';

class SettingsService {
  SettingsService._(this._prefs);

  final SharedPreferencesWithCache _prefs;

  static const _onboarding = 'hasCompletedOnboarding';
  static const _theme = 'themeMode';
  static const _language = 'languageCode';
  static const _defaultConnection = 'defaultConnectionType';
  static const _defaultReserve = 'defaultReserveFloorPercent';
  static const _meaningfulCount = 'meaningfulActionCountSinceAd';
  static const _lifetimeCalculations = 'lifetimeCompletedCalculations';
  static const _lastInterstitial = 'lastInterstitialAtEpochMs';
  static const _adsShownToday = 'adsShownToday';
  static const _lastAdDate = 'lastAdLocalDate';
  static const _sessionAdShown = 'sessionAdShown';
  static const _launchCount = 'launchCount';

  static const Set<String> _allowedKeys = {
    _onboarding,
    _theme,
    _language,
    _defaultConnection,
    _defaultReserve,
    _meaningfulCount,
    _lifetimeCalculations,
    _lastInterstitial,
    _adsShownToday,
    _lastAdDate,
    _sessionAdShown,
    _launchCount,
  };

  static Future<SettingsService> create() async {
    final prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: _allowedKeys,
      ),
    );
    return SettingsService._(prefs);
  }

  bool get hasCompletedOnboarding => _prefs.getBool(_onboarding) ?? false;
  Future<void> completeOnboarding() => _prefs.setBool(_onboarding, true);

  ThemeMode get themeMode => switch (_prefs.getString(_theme)) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    'system' => ThemeMode.system,
    _ => ThemeMode.dark,
  };

  Future<void> setThemeMode(ThemeMode mode) =>
      _prefs.setString(_theme, mode.name);

  /// Null follows the device language. Ignore unsupported stored preferences.
  String? get languageCode {
    final code = _prefs.getString(_language);
    return code != null && AppLanguages.supports(code) ? code : null;
  }

  Future<void> setLanguageCode(String? code) async {
    if (code == null) {
      await _prefs.remove(_language);
    } else {
      if (!AppLanguages.supports(code)) {
        throw ArgumentError.value(code, 'code', 'Unsupported app language');
      }
      await _prefs.setString(_language, code);
    }
  }

  String get defaultConnectionType =>
      _prefs.getString(_defaultConnection) ?? 'AC';

  Future<void> setDefaultConnectionType(String value) =>
      _prefs.setString(_defaultConnection, value);

  double get defaultReserveFloorPercent =>
      _prefs.getDouble(_defaultReserve) ?? 10;

  Future<void> setDefaultReserveFloorPercent(double value) =>
      _prefs.setDouble(_defaultReserve, value.clamp(0, 50).toDouble());

  int get meaningfulActionCountSinceAd => _prefs.getInt(_meaningfulCount) ?? 0;

  int get lifetimeCompletedCalculations =>
      _prefs.getInt(_lifetimeCalculations) ?? 0;

  int? get lastInterstitialAtEpochMs => _prefs.getInt(_lastInterstitial);

  int get adsShownToday => _prefs.getInt(_adsShownToday) ?? 0;

  String? get lastAdLocalDate => _prefs.getString(_lastAdDate);

  bool get sessionAdShown => _prefs.getBool(_sessionAdShown) ?? false;

  int get launchCount => _prefs.getInt(_launchCount) ?? 0;

  Future<void> beginSession() async {
    await _prefs.setBool(_sessionAdShown, false);
    await _prefs.setInt(_launchCount, launchCount + 1);
    await _resetDailyAdCountIfNeeded();
  }

  Future<void> registerMeaningfulCalculation() async {
    await _prefs.setInt(_meaningfulCount, meaningfulActionCountSinceAd + 1);
    await _prefs.setInt(
      _lifetimeCalculations,
      lifetimeCompletedCalculations + 1,
    );
  }

  bool get isAdFrequencyEligible {
    if (launchCount <= 1) return false;
    if (lifetimeCompletedCalculations < 4) return false;
    if (meaningfulActionCountSinceAd < 4) return false;

    final today = _dateKey(DateTime.now());
    final effectiveAdsToday = lastAdLocalDate == today ? adsShownToday : 0;
    if (effectiveAdsToday >= 2) return false;
    if (sessionAdShown) return false;

    final last = lastInterstitialAtEpochMs;
    if (last == null) return true;

    return DateTime.now().millisecondsSinceEpoch - last >=
        const Duration(minutes: 20).inMilliseconds;
  }

  Future<void> markAdShown() async {
    final now = DateTime.now();
    final today = _dateKey(now);
    final nextDailyCount = lastAdLocalDate == today ? adsShownToday + 1 : 1;

    await _prefs.setInt(_meaningfulCount, 0);
    await _prefs.setInt(_lastInterstitial, now.millisecondsSinceEpoch);
    await _prefs.setBool(_sessionAdShown, true);
    await _prefs.setString(_lastAdDate, today);
    await _prefs.setInt(_adsShownToday, nextDailyCount);
  }

  Future<void> resetDefaults() async {
    await _prefs.remove(_defaultConnection);
    await _prefs.remove(_defaultReserve);
  }

  Future<void> _resetDailyAdCountIfNeeded() async {
    final today = _dateKey(DateTime.now());
    if (lastAdLocalDate != today) {
      await _prefs.setString(_lastAdDate, today);
      await _prefs.setInt(_adsShownToday, 0);
    }
  }

  String _dateKey(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';
}
