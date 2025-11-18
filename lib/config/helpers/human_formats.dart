import 'package:intl/intl.dart';

class HumanFormats {

  static String humanReadbleNumber(double number) {
    final formatterNumber = NumberFormat.compact(
      locale: 'en'
    ).format(number);
    return formatterNumber;
  }

  static String number(double number) {
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
      locale: 'en'
    ).format(number);
    return formattedNumber;
  }
}