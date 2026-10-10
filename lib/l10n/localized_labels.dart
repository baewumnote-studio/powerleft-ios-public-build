import 'generated/app_localizations.dart';
import '../domain/models/enums.dart';

String localizedDeviceName(AppLocalizations l, String key) => switch (key) {
  'devicePortableFridge' => l.devicePortableFridge,
  'deviceElectricBlanket' => l.deviceElectricBlanket,
  'deviceLedLight' => l.deviceLedLight,
  'deviceFan' => l.deviceFan,
  'devicePhoneCharger' => l.devicePhoneCharger,
  'deviceLaptop' => l.deviceLaptop,
  'deviceCpap' => l.deviceCpap,
  'deviceRefrigerator' => l.deviceRefrigerator,
  'deviceFreezer' => l.deviceFreezer,
  'deviceWifiRouter' => l.deviceWifiRouter,
  'deviceModem' => l.deviceModem,
  'deviceTv' => l.deviceTv,
  'deviceDesktopPc' => l.deviceDesktopPc,
  'deviceProjector' => l.deviceProjector,
  'deviceSpeaker' => l.deviceSpeaker,
  'deviceCameraCharger' => l.deviceCameraCharger,
  'deviceDroneCharger' => l.deviceDroneCharger,
  'deviceCoffeeMaker' => l.deviceCoffeeMaker,
  'deviceMicrowave' => l.deviceMicrowave,
  'deviceInductionCooktop' => l.deviceInductionCooktop,
  'deviceHairDryer' => l.deviceHairDryer,
  'devicePortableMonitor' => l.devicePortableMonitor,
  'deviceWorkLight' => l.deviceWorkLight,
  'devicePowerToolCharger' => l.devicePowerToolCharger,
  'deviceSolderingIron' => l.deviceSolderingIron,
  _ => key,
};

String localizedCategory(AppLocalizations l, String id) => switch (id) {
  'camping' => l.categoryCamping,
  'home_backup' => l.categoryHomeBackup,
  'outdoor' => l.categoryOutdoor,
  'high_draw' => l.categoryHighDraw,
  'work' => l.categoryWork,
  _ => l.categoryAll,
};

String localizedUsage(AppLocalizations l, UsagePattern pattern) =>
    switch (pattern) {
      UsagePattern.alwaysOn => l.deviceUsageAlways,
      UsagePattern.usuallyOn => l.deviceUsageUsually,
      UsagePattern.cycles => l.deviceUsageCycles,
      UsagePattern.occasional => l.deviceUsageOccasional,
      UsagePattern.custom => l.deviceUsageCustom,
    };

String localizedRuntime(AppLocalizations l, double hours) {
  if (!hours.isFinite || hours <= 0) return '0 ${l.commonMinutesShort}';
  final totalMinutes = hours * 60;
  if (totalMinutes < 1) return '<1 ${l.commonMinutesShort}';
  if (totalMinutes < 60) {
    return '${totalMinutes.round()} ${l.commonMinutesShort}';
  }
  if (hours <= 24) {
    final roundedMinutes = (totalMinutes / 5).round() * 5;
    final h = roundedMinutes ~/ 60;
    final m = roundedMinutes % 60;
    return m == 0
        ? '$h ${l.commonHoursShort}'
        : '$h ${l.commonHoursShort} $m ${l.commonMinutesShort}';
  }
  final roundedHours = hours.round();
  final days = roundedHours ~/ 24;
  final h = roundedHours % 24;
  return h == 0
      ? '$days ${l.commonDaysShort}'
      : '$days ${l.commonDaysShort} $h ${l.commonHoursShort}';
}

/// Keeps each number and unit together in the narrow comparison cards.
/// The spoken value is still the full duration, including both components.
String localizedRuntimeCard(AppLocalizations l, double hours) {
  final duration = localizedRuntime(l, hours);
  final parts = duration.split(' ');
  if (parts.length == 4) {
    return '${parts[0]}\u00a0${parts[1]}\n${parts[2]}\u00a0${parts[3]}';
  }
  return duration.replaceAll(' ', '\u00a0');
}

String localizedDeviceId(AppLocalizations l, String? id, String fallback) =>
    switch (id) {
      'portable_fridge' => l.devicePortableFridge,
      'electric_blanket' => l.deviceElectricBlanket,
      'led_light' => l.deviceLedLight,
      'fan' => l.deviceFan,
      'phone_charger' => l.devicePhoneCharger,
      'laptop' => l.deviceLaptop,
      'cpap' => l.deviceCpap,
      'refrigerator' => l.deviceRefrigerator,
      'freezer' => l.deviceFreezer,
      'wifi_router' => l.deviceWifiRouter,
      'modem' => l.deviceModem,
      'tv' => l.deviceTv,
      'desktop_pc' => l.deviceDesktopPc,
      'projector' => l.deviceProjector,
      'speaker' => l.deviceSpeaker,
      'camera_charger' => l.deviceCameraCharger,
      'drone_charger' => l.deviceDroneCharger,
      'coffee_maker' => l.deviceCoffeeMaker,
      'microwave' => l.deviceMicrowave,
      'induction_cooktop' => l.deviceInductionCooktop,
      'hair_dryer' => l.deviceHairDryer,
      'portable_monitor' => l.devicePortableMonitor,
      'work_light' => l.deviceWorkLight,
      'power_tool_charger' => l.devicePowerToolCharger,
      'soldering_iron' => l.deviceSolderingIron,
      _ => fallback,
    };
