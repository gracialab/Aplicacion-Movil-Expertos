import 'package:intl/intl.dart';

class ParseNumber {
  static String currency({required num value, String name = 'COP'}) =>
      NumberFormat.simpleCurrency(name: name, locale: 'en', decimalDigits: 0)
          .format(value);
}
