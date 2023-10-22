import 'package:cinema_pedia/domain/entities/movie.dart';
import 'package:cinema_pedia/domain/entities/video.dart';


abstract class MoviesRepository {

  Future<List<Movie>> getNowPlaying({int page = 1});

  Future<List<Movie>> getPopular({int page = 1});

  Future<List<Movie>> getUpcoming({int page = 1});

  Future<List<Movie>> getTopRated({int page = 1});

  Future<List<Movie>> searchMovies(String query);

  Future<List<Movie>> getSimilarMovies( int movieId );

  Future<Movie> getMovieById(String id);


  // YouTube videos by Movie
  Future<List<Video>> getYoutubeVideosById( int movieId );

}
