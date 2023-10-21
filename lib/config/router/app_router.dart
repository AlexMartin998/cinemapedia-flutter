import 'package:cinema_pedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';


// facilita el W. Da compatibilidad web con deeplinking
final appRouter = GoRouter(
  initialLocation: '/home/0',

  routes: [
    GoRoute(
      // viene a ser la ruta raiz
      path: '/home/:page', // idx del tab to render
      name: HomeScreen.name,
      builder: (context, state) {
        // tomar el valor del Url Param
        final pageIndex = int.parse(state.pathParameters['page'] ?? '0');

        return HomeScreen(
          pageIndex: pageIndex,
        );
      },

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

    // // redirecciono a nuestro nuev sistema de rutas
    // ahora el   ( / -> /home/0 )
    GoRoute(
      path: '/',
      redirect: (_, __) => '/home/0',
    ),

  ]
);