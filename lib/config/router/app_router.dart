import 'package:cinema_pedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';


// facilita el W. Da compatibilidad web con deeplinking
final appRouter = GoRouter(
  initialLocation: '/',

  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),

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


  ]
);