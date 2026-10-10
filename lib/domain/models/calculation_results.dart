class RuntimeEstimate {
  const RuntimeEstimate({
    required this.conservativeHours,
    required this.typicalHours,
    required this.bestHours,
    required this.typicalEffectiveEnergyWh,
    required this.totalAverageLoadW,
    required this.totalRatedLoadW,
    required this.hasStartupSurge,
    required this.hasMedicalDevice,
    required this.isLowAcLoad,
    required this.outputLimitExceeded,
    required this.hasNoUsableEnergy,
  });

  final double conservativeHours;
  final double typicalHours;
  final double bestHours;
  final double typicalEffectiveEnergyWh;
  final double totalAverageLoadW;
  final double totalRatedLoadW;
  final bool hasStartupSurge;
  final bool hasMedicalDevice;
  final bool isLowAcLoad;
  final bool outputLimitExceeded;
  final bool hasNoUsableEnergy;
}

class BatteryNeededEstimate {
  const BatteryNeededEstimate({
    required this.minimumWh,
    required this.recommendedWh,
    required this.comfortableWh,
    required this.energyDemandWh,
    required this.totalAverageLoadW,
    required this.totalRatedLoadW,
    required this.hasStartupSurge,
    required this.hasMedicalDevice,
  });

  final double minimumWh;
  final double recommendedWh;
  final double comfortableWh;
  final double energyDemandWh;
  final double totalAverageLoadW;
  final double totalRatedLoadW;
  final bool hasStartupSurge;
  final bool hasMedicalDevice;
}
