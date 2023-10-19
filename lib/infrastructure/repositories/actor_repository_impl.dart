import 'package:cinema_pedia/domain/datasources/actors_datasource.dart';
import 'package:cinema_pedia/domain/entities/actor.dart';
import 'package:cinema_pedia/domain/repositories/actors_repository.dart';


class ActorRepositoryImpl extends ActorsRepository {

  final ActorsDatasource datasource;

  ActorRepositoryImpl({required this.datasource});


  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return datasource.getActorsByMovie(movieId);
  }

}
