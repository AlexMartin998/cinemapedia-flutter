import 'package:cinema_pedia/domain/entities/movie.dart';
import 'package:cinema_pedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/* 
  * State:
  {
    '23123': Movie(),
    '13453': Movie(),
  }
*/


// // // StateNotifierProvider to be used with StateNotifier
final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final getMovieById = ref.watch(movieRepositoryProvider).getMovieById; // no se invoca
  
  return MovieMapNotifier(getMovie: getMovieById);
});




// // // StateNotifier Generico para varios Providers de != useCases
typedef GetMovieCallback = Future<Movie>Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;

  MovieMapNotifier({
    required this.getMovie,
  }) : super({});


  // generico para usar cualquier useCase
  Future<void> loadMovie(String movieId) async {
    // si ya tengo la movie en cache (prev req), NO fetch it
    if (state[movieId] != null) return;

    final movie = await getMovie(movieId);

    state = { ...state, movieId: movie };
  }

}
