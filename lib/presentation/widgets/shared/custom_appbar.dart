import 'package:cinema_pedia/domain/entities/movie.dart';
import 'package:cinema_pedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinema_pedia/presentation/providers/movies/movies_repository_provider.dart';
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
                  // uso directo el movieRepo xq no estoy W con el StateNotifierProvider
                  final movieRepository = ref.read(movieRepositoryProvider);

                  // // SearchDelegate: moview opt xq se puede salir sin la movie
                  showSearch<Movie?>( // nos lo da flutter
                    context: context,
                    delegate: SearchMovieDelegate( // encargado de W la Busqueda
                      searchMovies: movieRepository.searchMovies
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