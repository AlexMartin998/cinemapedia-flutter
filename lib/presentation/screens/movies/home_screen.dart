import 'package:flutter/material.dart';
import 'package:cinema_pedia/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';


class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  // go_router me dira q View se quiere renderizar
  final StatefulNavigationShell navigationShell;

  const HomeScreen({
    super.key,
    required this.navigationShell,
  });


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: navigationShell, // view se cambia aqui

      // no se destruye, solo cambia el childView
      bottomNavigationBar: CustomBottomNavigation(navigationShell: navigationShell),
    );
  }
}
