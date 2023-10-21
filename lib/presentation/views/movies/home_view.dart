import 'package:cinema_pedia/presentation/providers/providers.dart';
import 'package:cinema_pedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// Consumer para 1   Statefull widget
class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}


// ConsumerState tiene acceso al   ref   sin necesidad de pasarlo x el builder <- Riverpod
class HomeViewState extends ConsumerState<HomeView> {

  // // lifecycle
  @override
  void initState() {
    super.initState(); // siempre se llama 1ro

    // // este notifier ya tien todo, aqui no me interesa nada mas q llamarlo
    // inicia la   req   con toda la clean arch
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(); // dentro de 1 method uso read() y NOOO watch
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }


  @override
  Widget build(BuildContext context) {
    // // riverpod retorna el State: List<Movie> del provider
    // app global loader
    final initialLoading = ref.watch(initialLoadingProvider);
    // if (initialLoading) return const FullScreenLoader(); // no daria t a cargar las images xq para eso debe crearse el widget. aqui ya tengo la data, pero no el widget

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upComingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);


    return Visibility(
      visible: !initialLoading,
      replacement: const FullScreenLoader(),

      // solo cuando deja de cargar
      child: CustomScrollView( // fix screen overflow
        physics: const BouncingScrollPhysics(), // rebote ios/android

        // sliver es 1 Widget q W directamente con el   Scroll
        slivers: [
    
          const SliverAppBar(
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: CustomAppbar(),
              titlePadding: EdgeInsets.zero,  // evitar pading en Android
              centerTitle: false,
            ),
          ),
    
    
          SliverList(
            // fn q permite crear widgets dentro de esta list
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(
                  children: [
                    // const CustomAppbar(), // without CustomScrollView
                    const SizedBox(height: 9),
                    MoviesSlideshow(movies: slideShowMovies),
                    const SizedBox(height: 15),
    
                    /* Now playing */
                    MovieHorizontalListview(
                      movies: nowPlayingMovies,
                      title: 'En cines',
                      subTitle: 'Lunes 20',
    
                      loadNextPage: () {
                        // read xq es 1 callback/method/fn/listener
                        ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                      },
                    ),
    
                    /* Coming soon */
                    MovieHorizontalListview(
                      movies: upcomingMovies,
                      title: 'Próximamente',
                      subTitle: 'Lunes 20',
    
                      loadNextPage: () {
                        // read xq es 1 callback/method/fn/listener
                        ref.read(upComingMoviesProvider.notifier).loadNextPage();
                      },
                    ),
    
                    /* Popular */
                    MovieHorizontalListview(
                      movies: popularMovies,
                      title: 'Populares',
                      // subTitle: 'En este mes',
    
                      loadNextPage: () {
                        // read xq es 1 callback/method/fn/listener
                        ref.read(popularMoviesProvider.notifier).loadNextPage();
                      },
                    ),
    
                    /* Top rated */
                    MovieHorizontalListview(
                      movies: topRatedMovies,
                      title: 'Mejor calificadas',
                      subTitle: 'Desde siempre',
    
                      loadNextPage: () {
                        // read xq es 1 callback/method/fn/listener
                        ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                      },
                    ),
    
                    const SizedBox(height: 12), // bottom de gracia para q se vea todo bien
    
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
    
              },
    
              childCount: 1  // veces q se repite el child
            ),
          )
        ]
    
      ),
    );
  }
}