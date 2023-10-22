import 'package:cinema_pedia/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
  (ref) => ThemeNotifier(), // la 1ra instancia
);


class ThemeNotifier extends StateNotifier<AppTheme> {

  // crear la 1ra   INSTANCIA   del AppTheme   <---   STATE = new AppTheme()
  ThemeNotifier() : super(AppTheme()); // super setea el initi state (must be sycn)


  // state: tiene acceso a todas las props del AppTheme
  void toggleDarkMode() {
    // riverpod detecta el cambio del state y NOTIFICA en auto para q se hagan re-renders 
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

}
