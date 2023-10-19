import 'package:cinema_pedia/domain/entities/movie.dart';
import 'package:cinema_pedia/presentation/providers/movies/movie_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



// // ConsumerStatefulWidget: Riverpod provider CONSUMER dor StatFUL widgets
class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';

  // // deeplinking: share page para 1 con el deeplinking entren a esa misma page en la App
  // igual para la web: si entro directo al deeplinking NO tengo Movide, sino el ID
  final String movieId; // sin id lo saco

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}


// ConsumerState: acceso al   ref   sin necesidad de pasarlo x el .builder()
class MovieScreenState extends ConsumerState<MovieScreen> {

  @override
  void initState() { // ngOnInit() :v
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
  }


  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];
    if (movie == null ) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }



    return Scaffold(
      appBar: AppBar(
        title: Text('MovieID: ${widget.movieId}'),
      ),
    );
  }
}
