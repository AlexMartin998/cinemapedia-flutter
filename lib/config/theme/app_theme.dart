import 'package:flutter/material.dart';

class AppTheme {
  final bool isDarkMode;

  AppTheme({
    this.isDarkMode = true
  });

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    // colorSchemeSeed: const Color(0xFF2862F5), // color hexagesimal
    colorSchemeSeed: Colors.white,

    brightness: isDarkMode ? Brightness.dark : Brightness.light,  // dark mode
  );


  // mantener state inmutable. Si cambia algo en el state, Creamos 1 nuevo state basado en el anterior <- esencia del copyWith() muy usado en la vida real
    AppTheme copyWith({
      int? selectedColor,
      bool? isDarkMode
    }) => AppTheme(
    // como es opt, si no me lo envia uso el q tengo en la class
    isDarkMode: isDarkMode ?? this.isDarkMode
  );

}