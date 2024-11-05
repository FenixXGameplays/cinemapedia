import 'package:intl/intl.dart';

class HumanFormat {

  static String numberFormatted (double number){
    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
      locale: 'en'
      ).format(number);
      return formatterNumber;
  }
}