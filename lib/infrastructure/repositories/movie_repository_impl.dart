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

}