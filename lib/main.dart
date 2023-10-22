import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:cinema_pedia/config/theme/app_theme.dart';
import 'package:cinema_pedia/config/router/app_router.dart';
import 'package:cinema_pedia/presentation/providers/theme_provider.dart';


Future<void> main() async {
  // envV
  await dotenv.load(fileName: '.env');

  runApp(
    const ProviderScope(
      child: MainApp(),
    )
  );
}


class MainApp extends ConsumerWidget {
  const MainApp({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    initializeDateFormatting(); // DateFormat

    final AppTheme appTheme = ref.watch(themeNotifierProvider);


    return MaterialApp.router(
      routerConfig: appRouter,

      debugShowCheckedModeBanner: false,

      theme: appTheme.getTheme(),
    );
  }
}
