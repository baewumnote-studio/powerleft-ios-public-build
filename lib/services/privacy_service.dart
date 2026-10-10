import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class PrivacyService {
  bool _updatedThisSession = false;
  Future<void>? _updateFuture;
  Future<void>? _consentFormFuture;

  ConsentRequestParameters _requestParameters() {
    if (!kDebugMode) {
      return ConsentRequestParameters();
    }

    const geography = String.fromEnvironment('UMP_DEBUG_GEOGRAPHY');
    const testDeviceId = String.fromEnvironment('UMP_TEST_DEVICE_ID');

    DebugGeography? debugGeography;
    switch (geography.toUpperCase()) {
      case 'EEA':
        debugGeography = DebugGeography.debugGeographyEea;
      case 'US':
      case 'REGULATED_US':
        debugGeography = DebugGeography.debugGeographyRegulatedUsState;
      case 'OTHER':
        debugGeography = DebugGeography.debugGeographyOther;
    }

    if (debugGeography == null && testDeviceId.isEmpty) {
      return ConsentRequestParameters();
    }

    return ConsentRequestParameters(
      consentDebugSettings: ConsentDebugSettings(
        debugGeography: debugGeography ?? DebugGeography.debugGeographyDisabled,
        testIdentifiers: testDeviceId.isEmpty ? const [] : [testDeviceId],
      ),
    );
  }

  Future<void> resetForTesting() async {
    if (!kDebugMode) return;
    await ConsentInformation.instance.reset();
    _updatedThisSession = false;
    _updateFuture = null;
    _consentFormFuture = null;
  }

  Future<void> updateConsentInfo() {
    if (_updatedThisSession) return Future<void>.value();

    final active = _updateFuture;
    if (active != null) return active;

    final future = _performConsentInfoUpdate();
    _updateFuture = future;
    return future.whenComplete(() {
      if (identical(_updateFuture, future)) {
        _updateFuture = null;
      }
    });
  }

  Future<void> _performConsentInfoUpdate() async {
    final completer = Completer<void>();

    try {
      ConsentInformation.instance.requestConsentInfoUpdate(
        _requestParameters(),
        () {
          _updatedThisSession = true;
          if (!completer.isCompleted) completer.complete();
        },
        (error) {
          // Previous-session consent may still be valid after an update error.
          _updatedThisSession = true;
          if (!completer.isCompleted) completer.complete();
        },
      );
    } catch (_) {
      _updatedThisSession = true;
      if (!completer.isCompleted) completer.complete();
    }

    await completer.future;
  }

  Future<void> ensureConsentForAds() {
    final active = _consentFormFuture;
    if (active != null) return active;

    final future = _performConsentFormFlow();
    _consentFormFuture = future;
    return future.whenComplete(() {
      if (identical(_consentFormFuture, future)) {
        _consentFormFuture = null;
      }
    });
  }

  Future<void> _performConsentFormFlow() async {
    await updateConsentInfo();

    final completer = Completer<void>();
    try {
      await ConsentForm.loadAndShowConsentFormIfRequired((error) {
        if (!completer.isCompleted) completer.complete();
      });
    } catch (_) {
      if (!completer.isCompleted) completer.complete();
    }
    await completer.future;
  }

  Future<bool> canRequestAds() async {
    await updateConsentInfo();
    return ConsentInformation.instance.canRequestAds();
  }

  Future<bool> privacyOptionsRequired() async {
    await updateConsentInfo();
    final status = await ConsentInformation.instance
        .getPrivacyOptionsRequirementStatus();
    return status == PrivacyOptionsRequirementStatus.required;
  }

  Future<FormError?> showPrivacyOptions() async {
    await updateConsentInfo();

    final completer = Completer<FormError?>();
    try {
      await ConsentForm.showPrivacyOptionsForm((error) {
        if (!completer.isCompleted) completer.complete(error);
      });
    } catch (_) {
      if (!completer.isCompleted) completer.complete(null);
    }
    return completer.future;
  }
}
