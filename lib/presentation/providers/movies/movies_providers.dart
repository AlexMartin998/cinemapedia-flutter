import 'package:cinema_pedia/domain/entities/movie.dart';
import 'package:cinema_pedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// // Como este Provider tedremos mas x c/use_case q llamara su propia fn
// quien maneja el state es el MoviesNotifier, de la data/state q es List<Movie>
final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  
  // method d nuestro Repo q es quien llama al datasource q realmente hace la Req Http
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;


  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );

});





// // // Notifier
// like a use case
typedef MovieCallback = Future<List<Movie>> Function({int page});

// es generico para unicamente mantener el State de las Movies
class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  MovieCallback fetchMoreMovies;


  // al init no tenemos movies, xq no tenemos methods q load form DB
  MoviesNotifier({
    required this.fetchMoreMovies
  }): super([]);


  // load next page y mantenerlas en memoria
  Future<void> loadNextPage() async {
    currentPage++;

    // obtengo las nuevas pelis con esta fn
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    
    // como cambia el state, Riverpod Notifica en auto
    state = [...state, ...movies]; // cambio state basado en prev state
  }

}


