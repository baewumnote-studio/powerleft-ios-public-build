import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:powerleft/domain/calculation/calculation_engine.dart';
import 'package:powerleft/domain/models/device_input.dart';
import 'package:powerleft/domain/models/enums.dart';

void main() {
  const engine = CalculationEngine();

  ConnectionType connection(String value) => ConnectionTypeX.fromWire(value);

  DeviceInput deviceFromJson(Map<String, dynamic> raw) {
    final hasExplicitFactor = raw.containsKey('usageFactor');
    final pattern = hasExplicitFactor
        ? UsagePattern.custom
        : UsagePatternX.fromWire(raw['usagePattern'] as String? ?? 'alwaysOn');

    return DeviceInput(
      name: 'Vector Device',
      watts: (raw['watts'] as num).toDouble(),
      usagePattern: pattern,
      customUsageFactor: hasExplicitFactor
          ? (raw['usageFactor'] as num).toDouble()
          : null,
      connectionOverride: raw['connectionOverride'] == null
          ? null
          : connection(raw['connectionOverride'] as String),
    );
  }

  double expected(Map<String, dynamic> result, String key) =>
      (result[key] as num).toDouble();

  final cases = _loadCases();
  for (final dynamic rawCase in cases) {
    final testCase = rawCase as Map<String, dynamic>;
    final id = testCase['id'] as String;
    final mode = testCase['mode'] as String;

    test('reference vector: $id', () {
      final devices = (testCase['devices'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(deviceFromJson)
          .toList(growable: false);

      final expectedResult = testCase['expected'] as Map<String, dynamic>;

      if (mode == 'runtime') {
        final result = engine.runtime(
          capacityWh: (testCase['capacityWh'] as num).toDouble(),
          chargePercent: (testCase['chargePercent'] as num).toDouble(),
          defaultConnection: connection(testCase['connection'] as String),
          devices: devices,
          customTypicalEfficiency: (testCase['customTypicalEfficiency'] as num?)
              ?.toDouble(),
          customReserveFloorPercent:
              (testCase['customReserveFloorPercent'] as num?)?.toDouble(),
        );

        expect(
          result.conservativeHours,
          closeTo(expected(expectedResult, 'conservative'), 1e-6),
        );
        expect(
          result.typicalHours,
          closeTo(expected(expectedResult, 'typical'), 1e-6),
        );
        expect(
          result.bestHours,
          closeTo(expected(expectedResult, 'best'), 1e-6),
        );
        expect(
          result.totalAverageLoadW,
          closeTo(expected(expectedResult, 'totalAverageLoadW'), 1e-6),
        );
        expect(
          result.totalRatedLoadW,
          closeTo(expected(expectedResult, 'totalRatedLoadW'), 1e-6),
        );
        expect(
          result.hasNoUsableEnergy,
          expectedResult['hasNoUsableEnergy'] as bool,
        );
      } else {
        final result = engine.batteryNeeded(
          desiredRuntimeHours: (testCase['desiredRuntimeHours'] as num)
              .toDouble(),
          defaultConnection: connection(testCase['connection'] as String),
          devices: devices,
        );

        expect(
          result.minimumWh,
          closeTo(expected(expectedResult, 'minimumWh'), 1e-6),
        );
        expect(
          result.recommendedWh,
          closeTo(expected(expectedResult, 'recommendedWh'), 1e-6),
        );
        expect(
          result.comfortableWh,
          closeTo(expected(expectedResult, 'comfortableWh'), 1e-6),
        );
        expect(
          result.energyDemandWh,
          closeTo(expected(expectedResult, 'energyDemandWh'), 1e-6),
        );
        expect(
          result.totalAverageLoadW,
          closeTo(expected(expectedResult, 'totalAverageLoadW'), 1e-6),
        );
      }
    });
  }
}

/// Tests are declared from the reviewed JSON vectors at test discovery time.
List<dynamic> _loadCases() {
  final decoded =
      jsonDecode(File('qa/CALCULATION_TEST_VECTORS.json').readAsStringSync())
          as Map<String, dynamic>;
  return decoded['cases'] as List<dynamic>;
}
