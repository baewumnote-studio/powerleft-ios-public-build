import '../../domain/models/enums.dart';

class AppliancePreset {
  const AppliancePreset({
    required this.id,
    required this.nameKey,
    required this.category,
    required this.minWatts,
    required this.maxWatts,
    required this.suggestedUsage,
    required this.hasStartupSurge,
    required this.isMedicalRelated,
  });

  final String id;
  final String nameKey;
  final String category;
  final double minWatts;
  final double maxWatts;
  final UsagePattern suggestedUsage;
  final bool hasStartupSurge;
  final bool isMedicalRelated;

  double get midpointWatts => (minWatts + maxWatts) / 2;

  factory AppliancePreset.fromJson(Map<String, dynamic> json) {
    final range = (json['rangeW'] as List).cast<num>();
    return AppliancePreset(
      id: json['id'] as String,
      nameKey: json['nameKey'] as String,
      category: json['category'] as String,
      minWatts: range.first.toDouble(),
      maxWatts: range.last.toDouble(),
      suggestedUsage: UsagePatternX.fromWire(json['suggestedUsage'] as String),
      hasStartupSurge: json['hasStartupSurge'] as bool? ?? false,
      isMedicalRelated: json['isMedicalRelated'] as bool? ?? false,
    );
  }
}
