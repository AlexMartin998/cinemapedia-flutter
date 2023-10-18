import 'package:cinema_pedia/domain/entities/movie.dart';
import 'package:cinema_pedia/presentation/providers/movies/movies_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// solo lectura: provider q consume otro provider y esta atento a los cambios (watch)
final moviesSlideshowProvider = Provider<List<Movie>>((ref) {
  // // el ref es de todos los provider
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

  if (nowPlayingMovies.isEmpty) return [];

  return nowPlayingMovies.sublist(0, 6);
});