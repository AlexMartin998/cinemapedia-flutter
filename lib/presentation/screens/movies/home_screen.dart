import 'package:cinema_pedia/presentation/providers/providers.dart';
import 'package:cinema_pedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: _HomeView(),

      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}




// Consumer para 1   Statefull widget
class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}


// ConsumerState tiene acceso al   ref   sin necesitad de pasarlo x el builder
class _HomeViewState extends ConsumerState<_HomeView> {

  // // lifecycle
  @override
  void initState() {
    super.initState(); // siempre se llama 1ro

    // // este notifier ya tien todo, aqui no me interesa nada mas q llamarlo
    // inicia la   req   con toda la clean arch
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(); // dentro de 1 method uso read() y NOOO watch
  }


  @override
  Widget build(BuildContext context) {
    // // riverpod retorna el State: List<Movie> del provider
    // final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);

    return Column(

      children: [
        const CustomAppbar(),

        MoviesSlideshow(movies: slideShowMovies),

        /* Expanded( // toma todo el espacio disponible del parent
          child: ListView.builder( // requiere heigth/width fijo
            padding: EdgeInsets.zero, // remove paddings
            itemCount: nowPlayingMovies.length,
        
            itemBuilder: (context, index) {
              final movie = nowPlayingMovies[index];
        
              return ListTile(
                title: Text(movie.title),
              );
            },
          ),
        ), */

      ],
    );
  }
}