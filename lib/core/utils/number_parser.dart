import 'package:intl/intl.dart';

abstract final class PowerNumberParser {
  static double? parseDecimal(String input, {String? locale}) {
    final compact = input
        .trim()
        .replaceAll('\u00A0', '')
        .replaceAll('\u202F', '')
        .replaceAll(' ', '');

    if (compact.isEmpty) return null;

    final localeName = Intl.canonicalizedLocale(
      locale ?? Intl.getCurrentLocale(),
    );
    final formatter = NumberFormat.decimalPattern(localeName);
    final symbols = formatter.symbols;

    final decimal = symbols.DECIMAL_SEP;
    final group = symbols.GROUP_SEP;

    // Mobile keyboards and pasted values sometimes use the "other"
    // punctuation mark as a decimal separator. Reinterpret it only when the
    // shape is clearly not a normal 3-digit grouping pattern.
    if (group != decimal &&
        (group == ',' || group == '.') &&
        !compact.contains(decimal) &&
        _count(compact, group) == 1) {
      final parts = compact.split(group);
      final before = parts.first.replaceFirst(RegExp(r'^[+-]'), '');
      final after = parts.last;

      final looksNumeric =
          RegExp(r'^\d+$').hasMatch(before) && RegExp(r'^\d+$').hasMatch(after);

      final likelyDecimal =
          looksNumeric && (after.length != 3 || before == '0');

      if (likelyDecimal) {
        final alternate = compact.replaceFirst(group, decimal);
        final value = formatter.tryParse(alternate);
        if (value != null) return value.toDouble();
      }
    }

    final parsed = formatter.tryParse(compact);
    return parsed?.toDouble();
  }

  static int _count(String text, String needle) {
    if (needle.isEmpty) return 0;
    return needle.allMatches(text).length;
  }
}
