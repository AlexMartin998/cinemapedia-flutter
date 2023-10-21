import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:cinema_pedia/presentation/views/views.dart';
import 'package:cinema_pedia/presentation/screens/screens.dart';


final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'moviesNav');

/* ** Mantener state (keepAlive) al navegar entre rutas: GoRouter Official Impl:
  * docs_url: https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart#L40C11-L40C11
*/
final appRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (
        BuildContext context, GoRouterState state,StatefulNavigationShell navigationShell
      ) {
          return HomeScreen(navigationShell: navigationShell);
      },

      branches: [
        // // The route branch for the 1st tab of the bottom navigation bar.
        StatefulShellBranch(
          navigatorKey: _sectionANavigatorKey,
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
          ],
        ),
        
        // // The route branch for the 2nd tab of the bottom navigation bar.
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/categories',
            builder: (context, state) => const Center(child: Text('Category')),
          )
        ]),

        // // The route branch for the 3rd tab of the bottom navigation bar.
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/favorites',
            builder: (context, state) => const FavoritesView(),
          )
        ]),
      ]
    ),



  /* // // Work with BottomNavigationBar - STATELESS
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

  */
  // // podriamos crear otras Parent Routes q se SALGAN del   ShellRoute
  // asi NO estaria siempre el BottomNavigationBar


  /* ** Rutas normales: Padre/Hijo
    GoRoute(
      // viene a ser la ruta raiz
      path: '/home/:page', // idx del tab to render
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
