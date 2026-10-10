abstract final class EnergyUnits {
  static double whToKwh(double wh) => wh / 1000;
  static double kwhToWh(double kwh) => kwh * 1000;

  static double whToAh({required double wh, required double voltage}) {
    if (wh <= 0 || voltage <= 0) {
      throw const FormatException('energy and voltage must be positive');
    }
    return wh / voltage;
  }

  static double ahToWh({required double ah, required double voltage}) {
    if (ah <= 0 || voltage <= 0) {
      throw const FormatException('capacity and voltage must be positive');
    }
    return ah * voltage;
  }
}
