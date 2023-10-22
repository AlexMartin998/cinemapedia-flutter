import 'package:cinema_pedia/domain/entities/video.dart';
import 'package:cinema_pedia/infrastructure/mappers/video_mapper.dart';
import 'package:dio/dio.dart';

import 'package:cinema_pedia/config/constants/environment.dart';
import 'package:cinema_pedia/domain/datasources/movies_datasource.dart';
import 'package:cinema_pedia/domain/entities/movie.dart';
import 'package:cinema_pedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinema_pedia/infrastructure/models/models.dart';


class MoviedbDatasource extends MoviesDataSource {

  // dio propio para este datasource
  final dio = Dio(BaseOptions(
    baseUrl: Environment.theMovieDbBaseUrl,

    queryParameters: {
      'api_key': Environment.theMovieDbKey,
      'language': 'es-MX'
    }
  ));


  // es quien hace el   fetch   a la API
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing', 
      queryParameters: {
        'page': page
      }
    );

    return _jsonToMovies(response.data);
  }


  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get(
      '/movie/popular', 
      queryParameters: {
        'page': page
      }
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get(
      '/movie/upcoming', 
      queryParameters: {
        'page': page
      }
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get(
      '/movie/top_rated', 
      queryParameters: {
        'page': page
      }
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200) throw Exception('Movie with id: $id not found');

    final movieDb = MovieDetails.fromJson(response.data);

    // map movie model (. notation) to entity
    final Movie movie = MovieMapper.movieDetailsToEntity(movieDb);

    return movie;
  }


  @override
  Future<List<Movie>> searchMovies(String query) async {
    // clean suggestions when query is empty
    if (query.isEmpty) return [];

    final response = await dio.get(
      '/search/movie', 
      queryParameters: {
        'query': query
      }
    );

    return _jsonToMovies(response.data);
  }


  @override
  Future<List<Movie>> getSimilarMovies(int movieId) async {
    // without paging
    final res = await dio.get('/movie/$movieId/similar');
    return _jsonToMovies(res.data);
  }


  @override
  Future<List<Video>> getYoutubeVideosById(int movieId) async {
    final response = await dio.get('/movie/$movieId/videos');
    final moviedbVideosReponse = MoviedbVideosResponse.fromJson(response.data);

    final videos = <Video>[];
    for (final movieDbVideo in moviedbVideosReponse.results) {
      if (movieDbVideo.site == 'YouTube') {
        final video = VideoMapper.moviedbVideoToEntity(movieDbVideo);

        videos.add(video);
      }
    }

    return videos;
  }



  List<Movie> _jsonToMovies(Map<String, dynamic> jsonData) {
    final movieDBResponse = MovieDbResponse.fromJson(jsonData);

    final List<Movie> movies = movieDBResponse.results
    // al ser 1 regla de negocio deberia estar el domain, pero como??? :v
    .where((movieDb) => movieDb.posterPath != 'no-poster')
    .map(
      (movieDb) => MovieMapper.movieDBToEntity(movieDb)
    ).toList();

    return movies;
  }
  
}
