import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigation({super.key, required this.currentIndex});

  void onDestinationSelected(BuildContext context, int index) {
    context.go('/home/$index');
  }

  
  @override
  Widget build(BuildContext context) {

    return NavigationBar(
      surfaceTintColor: Colors.transparent,
      onDestinationSelected: (value) => onDestinationSelected(context, value),
      selectedIndex: currentIndex,

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
