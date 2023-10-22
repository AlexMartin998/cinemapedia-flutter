import 'package:cinema_pedia/presentation/widgets/shared/custom_bottom_navigationbar.dart';
import 'package:flutter/material.dart';

import 'package:cinema_pedia/presentation/views/views.dart';



class HomeScreen extends StatefulWidget {
  static const name = 'home-screen';

  // keepAlive (tab navigation)
  final int pageIndex;

  const HomeScreen({super.key, required this.pageIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


// // // main impl for KeepAlive mixin (based on Index of viewRoutes)
// This Mixin is necessary to maintain the status in the PageView
class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {

  late PageController pageController;

  final viewRoutes =  const <Widget>[
    HomeView(),
    PopularView(), // popular
    FavoritesView(),
  ];


  // // lifecyle
  @override
  void initState() { // ngOnInit() :v
    super.initState();
    pageController = PageController(
      keepPage: true  // keep alive
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context); // req by AutomaticKeepAliveClientMixin

    // animate page change
    if (pageController.hasClients) {
      pageController.animateToPage(
        widget.pageIndex, 
        curve: Curves.easeInOut, 
        duration: const Duration( milliseconds: 252)
      );
    }

    // actual content:
    return Scaffold(
      body: PageView(
        // solo permite navegar entre pages/views con los tabs
        physics: const NeverScrollableScrollPhysics(),

        controller: pageController,
        children: viewRoutes,
      ),

      bottomNavigationBar: CustomBottomNavigation( 
        currentIndex: widget.pageIndex,
      ),
    );

  }


  // // keepalive mixin:
  @override
  bool get wantKeepAlive => true;

}



/* // // // Without PageView so without animation when change the page (just that style animation)
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
 */
