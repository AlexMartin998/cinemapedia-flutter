import 'package:cinema_pedia/domain/entities/movie.dart';
import 'package:cinema_pedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// si muto el state
final searchQueryProvider = StateProvider<String>((ref) => '');




// // // StateNotifierProvider to be used with StateNotifier
final searchedMoviesProvider =
  StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
    final movieRepository = ref.read(movieRepositoryProvider);

    return SearchedMoviesNotifier(
      searchMovies: movieRepository.searchMovies,
      ref: ref
    );
});



// // // StateNotifier Generico para varios Providers de != useCases
typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchMoviesCallback searchMovies;

  final Ref ref; // req la ref para up el query

  SearchedMoviesNotifier({
    required this.searchMovies,
    required this.ref,
  }):super([]);


  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final List<Movie> movies = await searchMovies(query);
    ref.read(searchQueryProvider.notifier).state = query; // upd query

    // no quiero mantener las prev movies, sino tener 1 nuevo result
    state = movies;

    return movies;
  }

}
