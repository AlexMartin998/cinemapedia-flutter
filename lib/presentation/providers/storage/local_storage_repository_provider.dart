import 'package:cinema_pedia/infrastructure/datasources/isar_datasource.dart';
import 'package:cinema_pedia/infrastructure/repositories/local_storage_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// // como es 1 provider q no se va a modificar, sera 1 de SOLO Lectura <- Provider()
final localStorageRepositoryProvider = Provider((ref) {

  // aqui es donde creamos la Instancia del RepoImpl pasandole el DatasourceImpl
  return LocalStorageRepositoryImpl(datasource: IsarDatasource());

});
