import 'package:flutter_test/flutter_test.dart';
import 'package:powerleft/domain/calculation/calculation_engine.dart';
import 'package:powerleft/domain/models/device_input.dart';
import 'package:powerleft/domain/models/enums.dart';

void main() {
  const engine = CalculationEngine();

  DeviceInput device(
    double watts, {
    UsagePattern pattern = UsagePattern.alwaysOn,
    ConnectionType? connection,
    bool surge = false,
  }) {
    return DeviceInput(
      name: 'Test',
      watts: watts,
      usagePattern: pattern,
      connectionOverride: connection,
      hasStartupSurge: surge,
    );
  }

  test('T01 AC 1000Wh 100% 90W produces documented range', () {
    final r = engine.runtime(
      capacityWh: 1000,
      chargePercent: 100,
      defaultConnection: ConnectionType.ac,
      devices: [device(90)],
    );

    expect(r.conservativeHours, closeTo(7.7444, 0.001));
    expect(r.typicalHours, closeTo(8.8, 0.001));
    expect(r.bestHours, closeTo(9.8167, 0.001));
  });

  test('T02 1024Wh 82% AC 167W typical', () {
    final r = engine.runtime(
      capacityWh: 1024,
      chargePercent: 82,
      defaultConnection: ConnectionType.ac,
      devices: [device(167)],
    );
    expect(r.typicalHours, closeTo(3.885, 0.002));
  });

  test('T03 battery needed 167W for 8h', () {
    final r = engine.batteryNeeded(
      desiredRuntimeHours: 8,
      defaultConnection: ConnectionType.ac,
      devices: [device(167)],
    );

    expect(r.energyDemandWh, closeTo(1336, 0.001));
    expect(r.minimumWh, closeTo(1436.56, 0.02));
    expect(r.recommendedWh, closeTo(1686.87, 0.02));
    expect(r.comfortableWh, closeTo(2036.59, 0.02));
  });

  test('charge below reserve gives zero runtime', () {
    final r = engine.runtime(
      capacityWh: 1000,
      chargePercent: 5,
      defaultConnection: ConnectionType.ac,
      devices: [device(50)],
    );
    expect(r.typicalHours, 0);
    expect(r.hasNoUsableEnergy, isTrue);
  });

  test('mixed AC and DC uses per-device conversion efficiency', () {
    final r = engine.runtime(
      capacityWh: 1000,
      chargePercent: 100,
      defaultConnection: ConnectionType.ac,
      devices: [
        device(100, connection: ConnectionType.ac),
        device(20, connection: ConnectionType.dc12v),
      ],
    );

    final expected = 900 / (100 / 0.88 + 20 / 0.92);
    expect(r.typicalHours, closeTo(expected, 0.001));
  });

  test('cycling device reduces average load', () {
    final r = engine.runtime(
      capacityWh: 1000,
      chargePercent: 100,
      defaultConnection: ConnectionType.ac,
      devices: [device(100, pattern: UsagePattern.cycles)],
    );
    expect(r.totalAverageLoadW, 50);
  });

  test('max output warning uses rated load not average load', () {
    final r = engine.runtime(
      capacityWh: 1000,
      chargePercent: 100,
      defaultConnection: ConnectionType.ac,
      devices: [device(1000, pattern: UsagePattern.occasional)],
      maxContinuousOutputW: 800,
    );
    expect(r.totalAverageLoadW, 250);
    expect(r.totalRatedLoadW, 1000);
    expect(r.outputLimitExceeded, isTrue);
  });

  test('surge flag propagates to result', () {
    final r = engine.runtime(
      capacityWh: 1000,
      chargePercent: 100,
      defaultConnection: ConnectionType.ac,
      devices: [device(100, surge: true)],
    );
    expect(r.hasStartupSurge, isTrue);
  });

  test('custom typical assumptions keep center value and create a range', () {
    final r = engine.runtime(
      capacityWh: 1000,
      chargePercent: 100,
      defaultConnection: ConnectionType.ac,
      devices: [device(100)],
      customTypicalEfficiency: 0.90,
      customReserveFloorPercent: 10,
    );

    expect(r.typicalHours, closeTo(8.1, 0.001));
    expect(r.conservativeHours, lessThan(r.typicalHours));
    expect(r.bestHours, greaterThan(r.typicalHours));
  });

  test('low AC warning follows actual device connection overrides', () {
    final noAc = engine.runtime(
      capacityWh: 1000,
      chargePercent: 100,
      defaultConnection: ConnectionType.ac,
      devices: [device(10, connection: ConnectionType.dc12v)],
    );
    expect(noAc.isLowAcLoad, isFalse);

    final overrideAc = engine.runtime(
      capacityWh: 1000,
      chargePercent: 100,
      defaultConnection: ConnectionType.dc12v,
      devices: [
        device(10, connection: ConnectionType.ac),
        device(40, connection: ConnectionType.dc12v),
      ],
    );
    expect(overrideAc.isLowAcLoad, isTrue);
  });

  test('rejects values outside supported domain limits', () {
    expect(
      () => engine.runtime(
        capacityWh: 100001,
        chargePercent: 100,
        defaultConnection: ConnectionType.ac,
        devices: [device(10)],
      ),
      throwsFormatException,
    );

    expect(
      () => engine.runtime(
        capacityWh: 1000,
        chargePercent: 100,
        defaultConnection: ConnectionType.ac,
        devices: [device(10001)],
      ),
      throwsFormatException,
    );

    expect(
      () => engine.batteryNeeded(
        desiredRuntimeHours: 337,
        defaultConnection: ConnectionType.ac,
        devices: [device(10)],
      ),
      throwsFormatException,
    );
  });

  test('runtime profile ordering holds across all connection types', () {
    for (final connection in ConnectionType.values) {
      final r = engine.runtime(
        capacityWh: 1500,
        chargePercent: 87,
        defaultConnection: connection,
        devices: [
          device(80, pattern: UsagePattern.cycles),
          device(25, pattern: UsagePattern.alwaysOn),
        ],
      );

      expect(r.conservativeHours, lessThanOrEqualTo(r.typicalHours));
      expect(r.typicalHours, lessThanOrEqualTo(r.bestHours));
    }
  });

  test('battery sizing ordering holds across all connection types', () {
    for (final connection in ConnectionType.values) {
      final r = engine.batteryNeeded(
        desiredRuntimeHours: 12,
        defaultConnection: connection,
        devices: [
          device(90, pattern: UsagePattern.cycles),
          device(12, pattern: UsagePattern.alwaysOn),
        ],
      );

      expect(r.minimumWh, lessThanOrEqualTo(r.recommendedWh));
      expect(r.recommendedWh, lessThanOrEqualTo(r.comfortableWh));
    }
  });

  test('more battery capacity never reduces runtime', () {
    final small = engine.runtime(
      capacityWh: 500,
      chargePercent: 100,
      defaultConnection: ConnectionType.ac,
      devices: [device(50)],
    );
    final large = engine.runtime(
      capacityWh: 1000,
      chargePercent: 100,
      defaultConnection: ConnectionType.ac,
      devices: [device(50)],
    );

    expect(large.typicalHours, greaterThan(small.typicalHours));
    expect(large.typicalHours / small.typicalHours, closeTo(2.0, 0.0001));
  });

  test('more charge never reduces runtime', () {
    final low = engine.runtime(
      capacityWh: 1000,
      chargePercent: 60,
      defaultConnection: ConnectionType.ac,
      devices: [device(50)],
    );
    final high = engine.runtime(
      capacityWh: 1000,
      chargePercent: 90,
      defaultConnection: ConnectionType.ac,
      devices: [device(50)],
    );

    expect(high.typicalHours, greaterThan(low.typicalHours));
  });

  test('more average load never increases runtime', () {
    final lowLoad = engine.runtime(
      capacityWh: 1000,
      chargePercent: 100,
      defaultConnection: ConnectionType.ac,
      devices: [device(50)],
    );
    final highLoad = engine.runtime(
      capacityWh: 1000,
      chargePercent: 100,
      defaultConnection: ConnectionType.ac,
      devices: [device(100)],
    );

    expect(highLoad.typicalHours, lessThan(lowLoad.typicalHours));
  });

  test('longer desired runtime requires more battery capacity', () {
    final short = engine.batteryNeeded(
      desiredRuntimeHours: 4,
      defaultConnection: ConnectionType.ac,
      devices: [device(100)],
    );
    final long = engine.batteryNeeded(
      desiredRuntimeHours: 12,
      defaultConnection: ConnectionType.ac,
      devices: [device(100)],
    );

    expect(long.recommendedWh, greaterThan(short.recommendedWh));
    expect(long.recommendedWh / short.recommendedWh, closeTo(3.0, 0.0001));
  });

  test('DC typical runtime is not worse than AC for same load', () {
    final ac = engine.runtime(
      capacityWh: 1000,
      chargePercent: 100,
      defaultConnection: ConnectionType.ac,
      devices: [device(100)],
    );
    final dc = engine.runtime(
      capacityWh: 1000,
      chargePercent: 100,
      defaultConnection: ConnectionType.dc12v,
      devices: [device(100)],
    );

    expect(dc.typicalHours, greaterThan(ac.typicalHours));
  });

  test('custom center assumptions remain bounded and ordered', () {
    final r = engine.runtime(
      capacityWh: 1200,
      chargePercent: 92,
      defaultConnection: ConnectionType.ac,
      devices: [device(75)],
      customTypicalEfficiency: 0.95,
      customReserveFloorPercent: 5,
    );

    expect(r.conservativeHours, lessThanOrEqualTo(r.typicalHours));
    expect(r.typicalHours, lessThanOrEqualTo(r.bestHours));
    expect(r.conservativeHours, greaterThan(0));
  });

  test('charge above reserve clears no-usable-energy warning', () {
    final r = engine.runtime(
      capacityWh: 1000,
      chargePercent: 50,
      defaultConnection: ConnectionType.ac,
      devices: [device(50)],
    );

    expect(r.typicalHours, greaterThan(0));
    expect(r.hasNoUsableEnergy, isFalse);
  });
}
