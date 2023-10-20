import 'package:cinema_pedia/domain/datasources/movies_datasource.dart';
import 'package:cinema_pedia/domain/entities/movie.dart';
import 'package:cinema_pedia/domain/repositories/movies_repository.dart';


class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDataSource moviesDataSource;


  MovieRepositoryImpl(this.moviesDataSource);


  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return moviesDataSource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return moviesDataSource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return moviesDataSource.getTopRated(page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return moviesDataSource.getUpcoming(page: page);
  }
  
  @override
  Future<Movie> getMovieById(String id) {
    return moviesDataSource.getMovieById(id);
  }
  
  @override
  Future<List<Movie>> searchMovies(String query) {
    return moviesDataSource.searchMovies(query);
  }

}