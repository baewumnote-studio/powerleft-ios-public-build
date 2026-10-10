import 'package:intl/intl.dart';

abstract final class PowerFormatters {
  static String runtime(double hours) {
    if (!hours.isFinite || hours <= 0) return '0 min';
    final totalMinutes = hours * 60;
    if (totalMinutes < 1) return '<1 min';
    if (totalMinutes < 60) {
      return '${totalMinutes.round()} min';
    }
    if (hours <= 24) {
      final roundedMinutes = (totalMinutes / 5).round() * 5;
      final h = roundedMinutes ~/ 60;
      final m = roundedMinutes % 60;
      return m == 0 ? '${h}h' : '${h}h ${m}m';
    }
    final roundedHours = hours.round();
    final days = roundedHours ~/ 24;
    final h = roundedHours % 24;
    return h == 0 ? '${days}d' : '${days}d ${h}h';
  }

  static String number(
    double value, {
    String? locale,
    int maxFractionDigits = 0,
    int minFractionDigits = 0,
  }) {
    if (!value.isFinite) return '—';

    final requiredZeros = minFractionDigits <= 0
        ? ''
        : '.${List.filled(minFractionDigits, '0').join()}';
    final optionalCount = maxFractionDigits > minFractionDigits
        ? maxFractionDigits - minFractionDigits
        : 0;
    final optionalHashes = optionalCount == 0
        ? ''
        : '${minFractionDigits == 0 ? '.' : ''}'
              '${List.filled(optionalCount, '#').join()}';

    final pattern = '#,##0$requiredZeros$optionalHashes';
    return NumberFormat(pattern, locale).format(value);
  }

  static String inputNumber(
    double value, {
    String? locale,
    int maxFractionDigits = 3,
  }) {
    if (!value.isFinite) return '';
    final optionalCount = maxFractionDigits > 0 ? maxFractionDigits : 0;
    final pattern = optionalCount == 0
        ? '0'
        : "0.${List.filled(optionalCount, '#').join()}";
    return NumberFormat(pattern, locale).format(value);
  }

  static String energy(double wh, {String? locale}) {
    if (!wh.isFinite) return '—';
    if (wh >= 1000) {
      return '${number(wh / 1000, locale: locale, minFractionDigits: 1, maxFractionDigits: 1)} kWh';
    }
    return '${number(wh.roundToDouble(), locale: locale)} Wh';
  }

  static String watts(
    double watts, {
    String? locale,
    int maxFractionDigits = 1,
  }) =>
      '${number(watts, locale: locale, maxFractionDigits: maxFractionDigits)} W';

  static double roundedPlanningCapacity(double wh) {
    if (wh <= 0) return 0;
    final step = wh < 1000 ? 50.0 : 100.0;
    return (wh / step).ceil() * step;
  }

  static String percent(double value) => '${value.clamp(0.0, 100.0).round()}%';
}
