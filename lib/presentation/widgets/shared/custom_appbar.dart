import 'package:cinema_pedia/domain/entities/movie.dart';
import 'package:cinema_pedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinema_pedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


// stateless -> ConsumerWidget | stateful -> ConsumerStatefulWidget  <-- Riverpod
class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),

        child: SizedBox(
          width: double.infinity, // todo el width q se pueda

          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: color.primary),
              const SizedBox(width: 5),
              Text('Cinemapedia', style: titleStyle),

              const Spacer(), // like flex 1
              IconButton(
                onPressed: () {
                  // // read on callbacks/listeners/onSomething
                  final searchMovies = ref.read(searchedMoviesProvider.notifier).searchMoviesByQuery;
                  final searchQuery = ref.read(searchQueryProvider); // return state
                  // save in memory to avoid loading (close/open searcher)
                  final searchedMovies = ref.read(searchedMoviesProvider); // state


                  // // SearchDelegate: moview opt xq se puede salir sin la movie
                  showSearch<Movie?>( // nos lo da flutter
                    query: searchQuery, // mantener state del Search (only Query)
                    context: context,

                    delegate: SearchMovieDelegate( // encargado de W la Busqueda
                      initialMovies: searchedMovies,
                      searchMovies: searchMovies
                    )
                  ).then((movie) {
                    // NUNCA usar el    context   dentro de 1  async xq este puede cambiar sin q nos demos cuenta
                    if (movie == null) return;
                    context.push('/movie/${movie.id}');
                  });
                },
                icon: const Icon(Icons.search)
              ),
            ],
          ),
        ),
      ),
    );
  }
}