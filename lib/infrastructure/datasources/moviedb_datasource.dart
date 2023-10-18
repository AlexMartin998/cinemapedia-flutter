import 'package:cinema_pedia/config/constants/environment.dart';
import 'package:cinema_pedia/domain/datasources/movies_datasource.dart';
import 'package:cinema_pedia/domain/entities/movie.dart';
import 'package:cinema_pedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinema_pedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';


class MoviedbDatasource extends MoviesDataSource {

  // dio propio para este datasource
  final dio = Dio(BaseOptions(
    baseUrl: Environment.theMovieDbBaseUrl,

    queryParameters: {
      'api_key': Environment.theMovieDbKey,
      'language': 'es-MX'
    }
  ));


  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing');
    
    final movieDBResponse = MovieDbResponse.fromJson(response.data);
    
    final List<Movie> movies = movieDBResponse.results
      // al ser 1 regla de negocio deberia estar el domain, pero como??? :v
      .where((movieDb) => movieDb.posterPath != 'no-poster')
      .map(
        (movieDb) => MovieMapper.movieDBToEntity(movieDb)
      ).toList();
    

    return movies;
  }

}
