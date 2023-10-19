import 'package:cinema_pedia/config/constants/environment.dart';
import 'package:cinema_pedia/domain/datasources/actors_datasource.dart';
import 'package:cinema_pedia/domain/entities/actor.dart';
import 'package:cinema_pedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinema_pedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';


class ActorMovieDbDatasource extends ActorsDatasource {

  // dio propio para este datasource
  final dio = Dio(BaseOptions(
    baseUrl: Environment.theMovieDbBaseUrl,

    queryParameters: {
      'api_key': Environment.theMovieDbKey,
      'language': 'es-MX'
    }
  ));


  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    // fetch data
    final res = await dio.get('/movie/$movieId/credits');

    // type response
    final creditsDb = CreditsResponse.fromJson(res.data);

    // build actorList
    final List<Actor> actorList = creditsDb.cast.map(
      (castDb) => ActorMapper.castToEntity(castDb)
    ).toList();
    
    return actorList;
  }

}