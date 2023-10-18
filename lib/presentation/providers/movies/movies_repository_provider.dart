import 'package:cinema_pedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinema_pedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// // como es 1 provider q no se va a modificar, sera 1 de SOLO Lectura <- Provider()
final movieRepositoryProvider = Provider((ref) { // inmutable

  // aqui es donde creamos la Instancia del RepoImpl pasandole el DatasourceImpl
  return MovieRepositoryImpl(MoviedbDatasource());

});
