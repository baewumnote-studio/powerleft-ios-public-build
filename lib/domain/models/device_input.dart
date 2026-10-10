import 'enums.dart';

class DeviceInput {
  const DeviceInput({
    required this.name,
    required this.watts,
    required this.usagePattern,
    this.customUsageFactor,
    this.connectionOverride,
    this.hasStartupSurge = false,
    this.isMedicalRelated = false,
    this.category = 'other',
    this.sourceApplianceId,
  });

  final String name;
  final double watts;
  final UsagePattern usagePattern;
  final double? customUsageFactor;
  final ConnectionType? connectionOverride;
  final bool hasStartupSurge;
  final bool isMedicalRelated;
  final String category;
  final String? sourceApplianceId;

  double get usageFactor =>
      customUsageFactor ?? usagePattern.defaultFactor(null);
  double get averageWatts => watts * usageFactor;

  DeviceInput copyWith({
    String? name,
    double? watts,
    UsagePattern? usagePattern,
    double? customUsageFactor,
    bool clearCustomUsageFactor = false,
    ConnectionType? connectionOverride,
    bool clearConnectionOverride = false,
    bool? hasStartupSurge,
    bool? isMedicalRelated,
    String? category,
    String? sourceApplianceId,
  }) {
    return DeviceInput(
      name: name ?? this.name,
      watts: watts ?? this.watts,
      usagePattern: usagePattern ?? this.usagePattern,
      customUsageFactor: clearCustomUsageFactor
          ? null
          : (customUsageFactor ?? this.customUsageFactor),
      connectionOverride: clearConnectionOverride
          ? null
          : (connectionOverride ?? this.connectionOverride),
      hasStartupSurge: hasStartupSurge ?? this.hasStartupSurge,
      isMedicalRelated: isMedicalRelated ?? this.isMedicalRelated,
      category: category ?? this.category,
      sourceApplianceId: sourceApplianceId ?? this.sourceApplianceId,
    );
  }
}
