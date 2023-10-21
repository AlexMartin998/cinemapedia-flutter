import 'package:cinema_pedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinema_pedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';


class IsarDatasource implements  LocalStorageDatasource {

  // conexion to DB NO Sync. We have to wait it
  late Future<Isar> db;

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    // create isntance for the 1st time
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [MovieSchema], // schemas generados
        inspector: true, // ver DB local
        directory: dir.path
      );
    }

    // return the previously created instance
    return Future.value(Isar.getInstance());
  }



  @override
  Future<bool> isMovieFavorite(int movieId) {
    // TODO: implement isMovieFavorite
    throw UnimplementedError();
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    // TODO: implement toggleFavorite
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    // TODO: implement loadMovies
    throw UnimplementedError();
  }

}