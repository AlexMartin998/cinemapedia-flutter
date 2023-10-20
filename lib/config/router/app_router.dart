import 'package:go_router/go_router.dart';

import 'package:cinema_pedia/presentation/views/views.dart';
import 'package:cinema_pedia/presentation/screens/screens.dart';


// facilita el W. Da compatibilidad web con deeplinking
final appRouter = GoRouter(
  initialLocation: '/',

  routes: [
    // // Work with BottomNavigationBar
    ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(childView: child);
      },

      // rutas
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return const HomeView();
          },

          // child route
          routes: [
            GoRoute(
              path: 'movie/:id', // always string
              name: MovieScreen.name,

              builder: (context, state) {
                final movieId = state.pathParameters['id'] ?? 'no-id';

                return MovieScreen(movieId: movieId);
              },
            ),
          ]
        ),

        GoRoute(
          path: '/favorites',
          builder: (context, state) => const FavoritesView(),
        )
      ]
    ),


    /* ** Rutas normales: Padre/Hijo
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(
        childView: HomeView(),
      ),

      // routes child
      routes: [
        GoRoute(
          path: 'movie/:id', // always string
          name: MovieScreen.name,

          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';

            return MovieScreen(movieId: movieId);
          },
        ),
      ]
    ),
    */

  ]
);