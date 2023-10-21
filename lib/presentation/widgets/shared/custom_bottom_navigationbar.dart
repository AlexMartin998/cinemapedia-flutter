import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class CustomBottomNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const CustomBottomNavigation({super.key, required this.navigationShell});

  void onDestinationSelected(int index) {
    navigationShell.goBranch(index);
  }


  @override
  Widget build(BuildContext context) {

    return NavigationBar(
      surfaceTintColor: Colors.transparent,

      // like onTap
      // onDestinationSelected: (value) => onDestinationSelected(value),
      onDestinationSelected: onDestinationSelected,
      selectedIndex: navigationShell.currentIndex,

      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_max),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.label_outline),
          label: 'Categories',
        ),
        NavigationDestination(
          icon: Icon(Icons.favorite_outline),
          label: 'Favorites',
        ),
      ],
    );
  }

}
