import 'package:cinema_pedia/presentation/views/movies/favorites_view.dart';
import 'package:cinema_pedia/presentation/views/movies/home_view.dart';
import 'package:cinema_pedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  // keepAlive (tab navigation)
  final int pageIndex;

  const HomeScreen({super.key, required this.pageIndex});

  // setea los Index para c/View
  final viewRoutes = const <Widget>[
    HomeView(),
    SizedBox(), // categories
    FavoritesView(),
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // preserva el State
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),

      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: pageIndex,
      ),
    );
  }
}
