import 'package:flutter/material.dart';
import '../../domain/models/power_limits.dart';

abstract final class AppValues {
  static const double screenPadding = 20;
  static const double cardPadding = 18;
  static const double cardRadius = 22;
  static const double heroCardRadius = 26;
  static const double inputRadius = 14;
  static const double buttonRadius = 18;
  static const double buttonHeight = 56;
  static const double minTapTarget = 44;

  static const Color lightPrimary = Color(0xFF123B33);
  static const Color lightAccent = Color(0xFF21C58B);
  static const Color lightAccentSoft = Color(0xFFD9F7EC);
  static const Color lightBackground = Color(0xFFF4F7F6);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceAlt = Color(0xFFEAF0EE);
  static const Color lightTextPrimary = Color(0xFF10211D);
  static const Color lightTextSecondary = Color(0xFF5C6965);
  static const Color lightDivider = Color(0xFFDDE6E2);
  static const Color lightWarning = Color(0xFFB86D12);
  static const Color lightCritical = Color(0xFFB83F46);

  static const Color darkPrimary = Color(0xFF75F2BF);
  static const Color darkAccent = Color(0xFF75F2BF);
  static const Color darkAccentSoft = Color(0xFF0B5948);
  static const Color darkBackground = Color(0xFF032720);
  static const Color darkSurface = Color(0xFF084236);
  static const Color darkSurfaceAlt = Color(0xFF052F27);
  static const Color darkTextPrimary = Color(0xFFF2F7F5);
  static const Color darkTextSecondary = Color(0xFFA7CCBD);
  static const Color darkDivider = Color(0xFF22695C);
  static const Color darkWarning = Color(0xFFF0B35B);
  static const Color darkCritical = Color(0xFFFF7A7A);

  static const double maxCapacityWh = PowerLimits.capacityWhMax;
  static const double maxDeviceWatts = PowerLimits.deviceWattsMax;
  static const double maxRuntimeHours = PowerLimits.runtimeHoursMax;
}
