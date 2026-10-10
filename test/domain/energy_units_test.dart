import 'package:flutter_test/flutter_test.dart';
import 'package:powerleft/domain/models/energy_units.dart';

void main() {
  test('Wh and kWh round-trip without changing energy', () {
    const wh = 1024.0;
    final kwh = EnergyUnits.whToKwh(wh);
    expect(kwh, 1.024);
    expect(EnergyUnits.kwhToWh(kwh), closeTo(wh, 0.000001));
  });

  test('Wh to Ah uses voltage', () {
    expect(EnergyUnits.whToAh(wh: 1200, voltage: 12), 100);
  });

  test('Ah to Wh uses voltage', () {
    expect(EnergyUnits.ahToWh(ah: 100, voltage: 12), 1200);
  });

  test('Wh/Ah conversion rejects non-positive values', () {
    expect(() => EnergyUnits.whToAh(wh: 0, voltage: 12), throwsFormatException);
    expect(
      () => EnergyUnits.ahToWh(ah: 100, voltage: 0),
      throwsFormatException,
    );
  });
}
