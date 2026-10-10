import 'package:flutter_test/flutter_test.dart';
import 'package:powerleft/core/utils/number_parser.dart';

void main() {
  test('parses US decimal and grouping', () {
    expect(PowerNumberParser.parseDecimal('1,500.5', locale: 'en_US'), 1500.5);
  });

  test('parses German decimal and grouping', () {
    expect(PowerNumberParser.parseDecimal('1.500,5', locale: 'de_DE'), 1500.5);
  });

  test('parses French grouped decimal', () {
    expect(PowerNumberParser.parseDecimal('1 500,5', locale: 'fr_FR'), 1500.5);
  });

  test('parses narrow-nbsp French grouped decimal', () {
    expect(
      PowerNumberParser.parseDecimal('1\u202F500,5', locale: 'fr_FR'),
      1500.5,
    );
  });

  test('parses Korean grouped decimal', () {
    expect(PowerNumberParser.parseDecimal('1,500.5', locale: 'ko_KR'), 1500.5);
  });

  test('accepts comma decimal pasted into English locale', () {
    expect(PowerNumberParser.parseDecimal('1,5', locale: 'en_US'), 1.5);
  });

  test('keeps normal English thousands grouping', () {
    expect(PowerNumberParser.parseDecimal('1,500', locale: 'en_US'), 1500);
  });

  test('accepts dot decimal pasted into German locale', () {
    expect(PowerNumberParser.parseDecimal('1.5', locale: 'de_DE'), 1.5);
  });

  test('keeps normal German thousands grouping', () {
    expect(PowerNumberParser.parseDecimal('1.500', locale: 'de_DE'), 1500);
  });

  test('treats zero-leading opposite separator as decimal', () {
    expect(PowerNumberParser.parseDecimal('0,500', locale: 'en_US'), 0.5);
  });

  test('returns null for invalid text', () {
    expect(PowerNumberParser.parseDecimal('abc', locale: 'en_US'), isNull);
  });
}
