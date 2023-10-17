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
    ),
  ]
);