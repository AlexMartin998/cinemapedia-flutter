import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  int _getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).fullPath ?? '/';
    switch(location) {
      case '/':
        return 0;
      case '/categories':
        return 1;
      case '/favorites':
        return 2;
      default:
        return 0;
    }
  }

  void onDestinationSelected(BuildContext context, int index) {
    switch(index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/');
        break;
      case 2:
        context.go('/favorites');
        break;
    }
  }


  @override
  Widget build(BuildContext context) {

    return NavigationBar(
      surfaceTintColor: Colors.transparent,

      // like onTap
      onDestinationSelected: (value) => onDestinationSelected(context, value),
      selectedIndex: _getCurrentIndex(context),

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
