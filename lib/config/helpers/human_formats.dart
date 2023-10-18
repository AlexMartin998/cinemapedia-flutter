import 'package:intl/intl.dart';


// wrapper class
class HumanFormats {

  static String number(double num) {
    // constructor con nombre
    final formattedNumeber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
      locale: 'en'
    ).format(num);
  
    return formattedNumeber;
  }

}