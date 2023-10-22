import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinema_pedia/domain/entities/movie.dart';
import 'package:cinema_pedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:cinema_pedia/presentation/widgets/movies/movie_horizontal_listview.dart';



// // // lo crea aqui x simplicidad ya q solo se va a usar aqui este provider
// // FutureProvider: Resolver Async Tasks to return a state
// debo consultar en db para saber el state y retornarlo. Como es Async uso FutureProvider
// .family() recibir Args en el provider
final similarMoviesProvider = FutureProvider.family((ref, int movieId) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return movieRepository.getSimilarMovies(movieId);
});


class SimilarMovies extends ConsumerWidget {
  final int movieId;

  const SimilarMovies({super.key, required this.movieId});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // future provider: value = AsyncValue<List<Movie>>
    final similarMoviesFuture = ref.watch(similarMoviesProvider(movieId));

    // Performs an action based on the state of the AsyncValue<> (List<Movie>)
    return similarMoviesFuture.when(
      data: (movies) => _Recomendations(movies: movies),

      error: (_ , __) => const Center(child: Text('No se pudo cargar películas similares') ), 
      loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );

  }
}



class _Recomendations extends StatelessWidget {
  final List<Movie> movies;

  const _Recomendations({ required this.movies });


  @override
  Widget build(BuildContext context) {

    if ( movies.isEmpty ) return const SizedBox();

    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 50),
      child: MovieHorizontalListview(
        title: 'Recomendaciones',
        movies: movies
      ),
    );
  }
}