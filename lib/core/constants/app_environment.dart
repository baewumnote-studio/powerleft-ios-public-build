import 'package:flutter/foundation.dart';

abstract final class AppEnvironment {
  static const bool _disableAdsDefine = bool.fromEnvironment(
    'POWERLEFT_DISABLE_ADS_FOR_TESTING',
    defaultValue: false,
  );

  static bool get adsDisabledForTesting => kDebugMode && _disableAdsDefine;
}
