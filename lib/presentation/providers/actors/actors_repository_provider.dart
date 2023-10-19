import 'package:cinema_pedia/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:cinema_pedia/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// inmutable
final actorsRepositoryProvider = Provider((ref) {

  // aqui es donde creamos la Instancia del RepoImpl pasandole el DatasourceImpl
  return ActorRepositoryImpl(datasource: ActorMovieDbDatasource());

});
