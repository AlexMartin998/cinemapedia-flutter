import 'package:cinema_pedia/domain/entities/movie.dart';
import 'package:cinema_pedia/domain/repositories/local_storage_repository.dart';
import 'package:cinema_pedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*  State:
  {
    23123: Movie(),
    13453: Movie(),
  }
 */


/* Aqui pasamos de 1 el RepositoryProvider, ya NO x c/use case */
// // // StateNotifierProvider to be used with StateNotifier
final favoriteMoviesProvider = StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  // aqui watch lo recomienda riverpod
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);

  return StorageMoviesNotifier(localStorageRepository: localStorageRepository);
});




// // // StateNotifier Generico para varios Providers de != useCases
class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {

  int page = 0;
  
  final LocalStorageRepository localStorageRepository;


  StorageMoviesNotifier({
    required this.localStorageRepository
  }): super({});


  Future<List<Movie>> loadNextPage() async {
    final movies = await localStorageRepository.loadMovies(offset: page * 10, limit: 20);
    page++;

    final tempMoviesMap = <int, Movie>{};
    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }

    state = { ...state, ...tempMoviesMap };

    return movies; // last movies
  }


  Future<void> toggleFavorite( Movie movie) async {
    await localStorageRepository.toggleFavorite(movie);

    final bool isMovieInFavorites = state[movie.id] != null;

    if (isMovieInFavorites) { // remove from favorites
      state.remove(movie.id);
      state = {...state}; // nofiticar cambio para re-render
    } else {
      state = {...state, movie.id: movie}; // add to favorites
    }

  }

}
