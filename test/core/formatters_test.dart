import 'package:flutter_test/flutter_test.dart';
import 'package:powerleft/core/utils/formatters.dart';

void main() {
  test('planning capacity rounds up under 1kWh in 50Wh steps', () {
    expect(PowerFormatters.roundedPlanningCapacity(721), 750);
  });

  test('planning capacity rounds up above 1kWh in 100Wh steps', () {
    expect(PowerFormatters.roundedPlanningCapacity(1686.9), 1700);
  });

  test('energy formats kWh', () {
    expect(PowerFormatters.energy(1700), '1.7 kWh');
  });

  test('formats German kWh with comma decimal', () {
    expect(PowerFormatters.energy(1700, locale: 'de_DE'), '1,7 kWh');
  });

  test('formats English kWh with dot decimal', () {
    expect(PowerFormatters.energy(1700, locale: 'en_US'), '1.7 kWh');
  });

  test('formats grouped whole Wh with locale grouping', () {
    expect(PowerFormatters.energy(950, locale: 'en_US'), '950 Wh');
  });

  test('percent clamps below zero', () {
    expect(PowerFormatters.percent(-2), '0%');
  });

  test('percent clamps above one hundred', () {
    expect(PowerFormatters.percent(145), '100%');
  });

  test('number supports optional fractional digits without num ambiguity', () {
    expect(
      PowerFormatters.number(12.345, locale: 'en_US', maxFractionDigits: 2),
      '12.35',
    );
  });

  test('inputNumber uses locale decimal without grouping', () {
    expect(
      PowerFormatters.inputNumber(
        1500.5,
        locale: 'en_US',
        maxFractionDigits: 2,
      ),
      '1500.5',
    );
    expect(
      PowerFormatters.inputNumber(
        1500.5,
        locale: 'de_DE',
        maxFractionDigits: 2,
      ),
      '1500,5',
    );
  });

  test('inputNumber trims unnecessary trailing zeros', () {
    expect(
      PowerFormatters.inputNumber(1000, locale: 'en_US', maxFractionDigits: 3),
      '1000',
    );
  });
}
