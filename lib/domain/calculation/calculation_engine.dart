import '../models/calculation_results.dart';
import '../models/device_input.dart';
import '../models/enums.dart';
import '../models/power_limits.dart';

class PowerProfile {
  const PowerProfile({
    required this.reserveFloorPercent,
    required this.efficiency,
  });

  final double reserveFloorPercent;
  final double efficiency;
}

abstract final class PowerDefaults {
  static const Map<ConnectionType, Map<CalculationProfile, PowerProfile>>
  profiles = {
    ConnectionType.ac: {
      CalculationProfile.conservative: PowerProfile(
        reserveFloorPercent: 15,
        efficiency: 0.82,
      ),
      CalculationProfile.typical: PowerProfile(
        reserveFloorPercent: 10,
        efficiency: 0.88,
      ),
      CalculationProfile.best: PowerProfile(
        reserveFloorPercent: 5,
        efficiency: 0.93,
      ),
    },
    ConnectionType.dc12v: {
      CalculationProfile.conservative: PowerProfile(
        reserveFloorPercent: 15,
        efficiency: 0.88,
      ),
      CalculationProfile.typical: PowerProfile(
        reserveFloorPercent: 10,
        efficiency: 0.92,
      ),
      CalculationProfile.best: PowerProfile(
        reserveFloorPercent: 5,
        efficiency: 0.96,
      ),
    },
    ConnectionType.usbC: {
      CalculationProfile.conservative: PowerProfile(
        reserveFloorPercent: 15,
        efficiency: 0.88,
      ),
      CalculationProfile.typical: PowerProfile(
        reserveFloorPercent: 10,
        efficiency: 0.92,
      ),
      CalculationProfile.best: PowerProfile(
        reserveFloorPercent: 5,
        efficiency: 0.96,
      ),
    },
  };
}

class CalculationEngine {
  const CalculationEngine();

  RuntimeEstimate runtime({
    required double capacityWh,
    required double chargePercent,
    required ConnectionType defaultConnection,
    required List<DeviceInput> devices,
    double? customTypicalEfficiency,
    double? customReserveFloorPercent,
    double? maxContinuousOutputW,
  }) {
    if (capacityWh <= PowerLimits.capacityWhMinExclusive ||
        capacityWh > PowerLimits.capacityWhMax) {
      throw const FormatException('capacityWh is outside supported range');
    }
    if (chargePercent < PowerLimits.chargePercentMin ||
        chargePercent > PowerLimits.chargePercentMax) {
      throw const FormatException('chargePercent must be between 0 and 100');
    }
    if (devices.isEmpty) {
      throw const FormatException('At least one device is required');
    }
    _validateDevices(devices);

    final totalAverageLoad = devices.fold<double>(
      0,
      (sum, d) => sum + d.averageWatts,
    );
    final totalRatedLoad = devices.fold<double>(0, (sum, d) => sum + d.watts);
    if (totalAverageLoad <= 0) {
      throw const FormatException('Total load must be > 0');
    }

    final conservative = _runtimeForProfile(
      profile: CalculationProfile.conservative,
      capacityWh: capacityWh,
      chargePercent: chargePercent,
      defaultConnection: defaultConnection,
      devices: devices,
      customTypicalEfficiency: customTypicalEfficiency,
      customReserveFloorPercent: customReserveFloorPercent,
    );
    final typical = _runtimeForProfile(
      profile: CalculationProfile.typical,
      capacityWh: capacityWh,
      chargePercent: chargePercent,
      defaultConnection: defaultConnection,
      devices: devices,
      customTypicalEfficiency: customTypicalEfficiency,
      customReserveFloorPercent: customReserveFloorPercent,
    );
    final best = _runtimeForProfile(
      profile: CalculationProfile.best,
      capacityWh: capacityWh,
      chargePercent: chargePercent,
      defaultConnection: defaultConnection,
      devices: devices,
      customTypicalEfficiency: customTypicalEfficiency,
      customReserveFloorPercent: customReserveFloorPercent,
    );

    final typicalReserve = _reserveFor(
      defaultConnection,
      CalculationProfile.typical,
      customReserveFloorPercent,
    );
    final usableChargeFraction =
        ((chargePercent - typicalReserve).clamp(0, 100)) / 100;
    final nominalAboveReserve = capacityWh * usableChargeFraction;
    final typicalEquivalentDraw = _equivalentBatteryDraw(
      devices,
      defaultConnection,
      CalculationProfile.typical,
      customTypicalEfficiency,
    );
    final typicalEffective = typicalEquivalentDraw <= 0
        ? 0.0
        : (nominalAboveReserve * totalAverageLoad / typicalEquivalentDraw);

    return RuntimeEstimate(
      conservativeHours: conservative,
      typicalHours: typical,
      bestHours: best,
      typicalEffectiveEnergyWh: typicalEffective,
      totalAverageLoadW: totalAverageLoad,
      totalRatedLoadW: totalRatedLoad,
      hasStartupSurge: devices.any((d) => d.hasStartupSurge),
      hasMedicalDevice: devices.any((d) => d.isMedicalRelated),
      isLowAcLoad: _isLowAcLoad(devices, defaultConnection),
      outputLimitExceeded:
          maxContinuousOutputW != null && totalRatedLoad > maxContinuousOutputW,
      hasNoUsableEnergy: usableChargeFraction <= 0,
    );
  }

  BatteryNeededEstimate batteryNeeded({
    required double desiredRuntimeHours,
    required ConnectionType defaultConnection,
    required List<DeviceInput> devices,
  }) {
    if (desiredRuntimeHours <= PowerLimits.runtimeHoursMinExclusive ||
        desiredRuntimeHours > PowerLimits.runtimeHoursMax) {
      throw const FormatException(
        'desiredRuntimeHours is outside supported range',
      );
    }
    if (devices.isEmpty) {
      throw const FormatException('At least one device is required');
    }
    _validateDevices(devices);

    final totalAverageLoad = devices.fold<double>(
      0,
      (sum, d) => sum + d.averageWatts,
    );
    final totalRatedLoad = devices.fold<double>(0, (sum, d) => sum + d.watts);
    if (totalAverageLoad <= 0) {
      throw const FormatException('Total load must be > 0');
    }

    final demand = totalAverageLoad * desiredRuntimeHours;

    final minimum = _capacityFor(
      demandWh: demand,
      devices: devices,
      defaultConnection: defaultConnection,
      profile: CalculationProfile.best,
      reserveFloor: 0,
    );
    final recommended = _capacityFor(
      demandWh: demand,
      devices: devices,
      defaultConnection: defaultConnection,
      profile: CalculationProfile.typical,
      reserveFloor: 10,
    );
    final comfortable = _capacityFor(
      demandWh: demand,
      devices: devices,
      defaultConnection: defaultConnection,
      profile: CalculationProfile.conservative,
      reserveFloor: 20,
    );

    return BatteryNeededEstimate(
      minimumWh: minimum,
      recommendedWh: recommended,
      comfortableWh: comfortable,
      energyDemandWh: demand,
      totalAverageLoadW: totalAverageLoad,
      totalRatedLoadW: totalRatedLoad,
      hasStartupSurge: devices.any((d) => d.hasStartupSurge),
      hasMedicalDevice: devices.any((d) => d.isMedicalRelated),
    );
  }

  void _validateDevices(List<DeviceInput> devices) {
    for (final device in devices) {
      if (device.watts <= PowerLimits.deviceWattsMinExclusive ||
          device.watts > PowerLimits.deviceWattsMax) {
        throw const FormatException(
          'device wattage is outside supported range',
        );
      }
      final factor = device.usageFactor;
      if (factor < PowerLimits.usageFactorMin ||
          factor > PowerLimits.usageFactorMax) {
        throw const FormatException(
          'device usage factor is outside supported range',
        );
      }
    }
  }

  bool _isLowAcLoad(
    List<DeviceInput> devices,
    ConnectionType defaultConnection,
  ) {
    final acLoad = devices
        .where(
          (device) =>
              (device.connectionOverride ?? defaultConnection) ==
              ConnectionType.ac,
        )
        .fold<double>(0, (sum, device) => sum + device.averageWatts);
    return acLoad > 0 && acLoad < 20;
  }

  double _runtimeForProfile({
    required CalculationProfile profile,
    required double capacityWh,
    required double chargePercent,
    required ConnectionType defaultConnection,
    required List<DeviceInput> devices,
    double? customTypicalEfficiency,
    double? customReserveFloorPercent,
  }) {
    final reserve = _reserveFor(
      defaultConnection,
      profile,
      customReserveFloorPercent,
    );
    final usableChargeFraction =
        ((chargePercent - reserve).clamp(0, 100)) / 100;
    if (usableChargeFraction <= 0) return 0;
    final nominalAboveReserve = capacityWh * usableChargeFraction;
    final equivalentDraw = _equivalentBatteryDraw(
      devices,
      defaultConnection,
      profile,
      customTypicalEfficiency,
    );
    return equivalentDraw <= 0 ? 0 : nominalAboveReserve / equivalentDraw;
  }

  double _equivalentBatteryDraw(
    List<DeviceInput> devices,
    ConnectionType defaultConnection,
    CalculationProfile profile,
    double? customTypicalEfficiency,
  ) {
    return devices.fold<double>(0, (sum, device) {
      final connection = device.connectionOverride ?? defaultConnection;
      final efficiency = _efficiencyFor(
        connection,
        profile,
        customTypicalEfficiency,
      );
      return sum + (device.averageWatts / efficiency);
    });
  }

  double _capacityFor({
    required double demandWh,
    required List<DeviceInput> devices,
    required ConnectionType defaultConnection,
    required CalculationProfile profile,
    required double reserveFloor,
  }) {
    final totalAverage = devices.fold<double>(
      0,
      (sum, d) => sum + d.averageWatts,
    );
    if (totalAverage <= 0) return 0;
    final weightedEquivalent = devices.fold<double>(0, (sum, d) {
      final connection = d.connectionOverride ?? defaultConnection;
      final efficiency =
          PowerDefaults.profiles[connection]![profile]!.efficiency;
      return sum + d.averageWatts / efficiency;
    });
    final lossAdjustedDemand = demandWh * (weightedEquivalent / totalAverage);
    final usableFraction = (100 - reserveFloor) / 100;
    return lossAdjustedDemand / usableFraction;
  }

  double _reserveFor(
    ConnectionType connection,
    CalculationProfile profile,
    double? customTypicalReserve,
  ) {
    if (customTypicalReserve == null) {
      return PowerDefaults.profiles[connection]![profile]!.reserveFloorPercent;
    }
    final r = customTypicalReserve.clamp(0, 50).toDouble();
    return switch (profile) {
      CalculationProfile.conservative => (r + 5).clamp(0, 50).toDouble(),
      CalculationProfile.typical => r,
      CalculationProfile.best => (r - 5).clamp(0, 50).toDouble(),
    };
  }

  double _efficiencyFor(
    ConnectionType connection,
    CalculationProfile profile,
    double? customTypicalEfficiency,
  ) {
    if (customTypicalEfficiency == null) {
      return PowerDefaults.profiles[connection]![profile]!.efficiency;
    }
    final e = customTypicalEfficiency.clamp(0.50, 0.99).toDouble();
    return switch (profile) {
      CalculationProfile.conservative =>
        (e - 0.06).clamp(0.50, 0.99).toDouble(),
      CalculationProfile.typical => e,
      CalculationProfile.best => (e + 0.05).clamp(0.50, 0.99).toDouble(),
    };
  }
}
