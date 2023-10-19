import 'package:flutter/material.dart';


class MovieScreen extends StatelessWidget {
  static const name = 'movie-screen';

  // // deeplinking: share page para 1 con el deeplinking entren a esa misma page en la App
  // igual para la web: si entro directo al deeplinking NO tengo Movide, sino el ID
  final String movieId; // sin id lo saco

  const MovieScreen({super.key, required this.movieId});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MovieID: $movieId'),
      ),
    );
  }

}
