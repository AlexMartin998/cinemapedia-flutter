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
  Future<bool> isMovieFavorite(int movieId) async {
    // wait for the DB to be available
    final isar = await db;

    final Movie? isFavoriteMovie = await isar.movies
      .filter() // to use isar filters
      .idEqualTo(movieId) // entity id
      .findFirst();

    return isFavoriteMovie != null;
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;

    final favoriteMovie = await isar.movies
      .filter()
      .idEqualTo(movie.id)
      .findFirst();
    
    // // Transactions: we can set severals operation in 1 Txn
    if (favoriteMovie != null) {
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId));
      return;
    }

    // insert
    isar.writeTxnSync(() => isar.movies.putSync(movie));
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    final isar = await db;

    return isar.movies.where()
      .offset(offset) // paging
      .limit(limit)
      .findAll();
  }

}