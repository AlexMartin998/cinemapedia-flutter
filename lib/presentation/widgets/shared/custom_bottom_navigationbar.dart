import 'package:flutter/material.dart';


class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  
  @override
  Widget build(BuildContext context) {

    return NavigationBar(
      surfaceTintColor: Colors.transparent,

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
