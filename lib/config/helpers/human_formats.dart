import 'package:intl/intl.dart';


// wrapper class
class HumanFormats {

  static String number(double num, [int decimals = 0]) {
    // constructor con nombre
    final formattedNumeber = NumberFormat.compactCurrency(
      decimalDigits: decimals,
      symbol: '',
      locale: 'en'
    ).format(num);
  
    return formattedNumeber;
  }

  static String shortDate( DateTime date ) {    
    final format = DateFormat.yMMMEd('es');
    return format.format(date);
  }

}