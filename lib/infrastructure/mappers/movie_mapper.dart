import 'package:cinema_pedia/domain/entities/movie.dart';
import 'package:cinema_pedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinema_pedia/infrastructure/models/moviedb/movie_moviewdb.dart';


// // mapear las Http Responses a nuestras Entities
class MovieMapper {

  static Movie movieDBToEntity(MovieMovieDB movieDB) {

    return Movie(
        adult: movieDB.adult,

        backdropPath: (movieDB.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500/${movieDB.backdropPath}'
          : 'https://sd.keepcalms.com/i/keep-calm-poster-not-found.png',

        genreIds: movieDB.genreIds.map((e) => e.toString()).toList(),
        id: movieDB.id,
        originalLanguage: movieDB.originalLanguage,
        originalTitle: movieDB.originalTitle,
        overview: movieDB.overview,
        popularity: movieDB.popularity,

        posterPath: (movieDB.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w500/${movieDB.posterPath}'
          : 'no-poster',

        releaseDate: movieDB.releaseDate,
        title: movieDB.title,
        video: movieDB.video,
        voteAverage: movieDB.voteAverage,
        voteCount: movieDB.voteCount
      );
  }


  static Movie movieDetailsToEntity(MovieDetails movieDetails) => Movie(
    adult: movieDetails.adult,

    backdropPath: (movieDetails.backdropPath != '')
      ? 'https://image.tmdb.org/t/p/w500/${movieDetails.backdropPath}'
      : 'https://sd.keepcalms.com/i/keep-calm-poster-not-found.png',

    genreIds: movieDetails.genres.map((e) => e.name).toList(),
    id: movieDetails.id,
    originalLanguage: movieDetails.originalLanguage,
    originalTitle: movieDetails.originalTitle,
    overview: movieDetails.overview,
    popularity: movieDetails.popularity,

    posterPath: (movieDetails.posterPath != '')
      ? 'https://image.tmdb.org/t/p/w500/${movieDetails.posterPath}'
      : 'https://sd.keepcalms.com/i/keep-calm-poster-not-found.png',

    releaseDate: movieDetails.releaseDate,
    title: movieDetails.title,
    video: movieDetails.video,
    voteAverage: movieDetails.voteAverage,
    voteCount: movieDetails.voteCount
  );
}
