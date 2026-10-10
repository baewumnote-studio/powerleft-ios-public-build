import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../core/constants/app_environment.dart';
import 'privacy_service.dart';
import 'settings_service.dart';

class AdService {
  AdService({required this._settings, required this._privacy});

  final SettingsService _settings;
  final PrivacyService _privacy;

  InterstitialAd? _interstitial;
  bool _loading = false;
  bool _sdkInitialized = false;
  bool _disposed = false;

  static const _iosTestInterstitial = 'ca-app-pub-3940256099942544/4411468910';

  String? get _adUnitId {
    if (kDebugMode) return _iosTestInterstitial;
    const production = String.fromEnvironment('ADMOB_INTERSTITIAL_IOS');
    return production.isEmpty ? null : production;
  }

  Future<void> initialize() async {
    if (AppEnvironment.adsDisabledForTesting || _disposed || _sdkInitialized) {
      return;
    }

    try {
      await MobileAds.instance.updateRequestConfiguration(
        RequestConfiguration(maxAdContentRating: MaxAdContentRating.g),
      );
      if (_disposed) return;

      await MobileAds.instance.initialize();
      if (_disposed) return;
      _sdkInitialized = true;

      if (await _privacy.canRequestAds()) {
        await preload();
      }
    } catch (_) {
      // Advertising must never block or crash the core calculator.
      _sdkInitialized = false;
    }
  }

  Future<void> preload() async {
    if (AppEnvironment.adsDisabledForTesting) return;
    if (_disposed || !_sdkInitialized || _loading || _interstitial != null) {
      return;
    }

    try {
      if (!await _privacy.canRequestAds()) return;
      if (_disposed) return;

      final id = _adUnitId;
      if (id == null) return;

      _loading = true;
      await InterstitialAd.load(
        adUnitId: id,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            _loading = false;
            if (_disposed) {
              unawaited(ad.dispose());
              return;
            }
            _interstitial = ad;
          },
          onAdFailedToLoad: (error) {
            _loading = false;
            _interstitial = null;
          },
        ),
      );
    } catch (_) {
      _loading = false;
      _interstitial = null;
    }
  }

  /// Call only at a natural transition after the result has already been seen.
  /// Any ad/consent failure returns false so navigation can continue normally.
  Future<bool> showIfEligible() async {
    if (AppEnvironment.adsDisabledForTesting ||
        _disposed ||
        !_settings.isAdFrequencyEligible) {
      return false;
    }

    try {
      if (!await _privacy.canRequestAds()) {
        await _privacy.ensureConsentForAds();
      }
      if (_disposed || !await _privacy.canRequestAds()) return false;

      final ad = _interstitial;
      if (ad == null) {
        await preload();
        return false;
      }

      final completer = Completer<bool>();
      _interstitial = null;
      var countedAsShown = false;

      ad.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (_) {
          if (!countedAsShown) {
            countedAsShown = true;
            unawaited(_settings.markAdShown());
          }
        },
        onAdDismissedFullScreenContent: (shownAd) async {
          await shownAd.dispose();
          if (!completer.isCompleted) completer.complete(true);
          if (!_disposed) await preload();
        },
        onAdFailedToShowFullScreenContent: (failedAd, error) async {
          await failedAd.dispose();
          if (!completer.isCompleted) completer.complete(false);
          if (!_disposed) await preload();
        },
      );

      try {
        await ad.show();
      } catch (_) {
        await ad.dispose();
        if (!completer.isCompleted) completer.complete(false);
        if (!_disposed) await preload();
      }

      return await completer.future;
    } catch (_) {
      return false;
    }
  }

  void dispose() {
    _disposed = true;
    _loading = false;
    final ad = _interstitial;
    _interstitial = null;
    if (ad != null) {
      unawaited(ad.dispose());
    }
  }
}
