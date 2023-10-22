import 'dart:math';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import 'package:cinema_pedia/domain/entities/movie.dart';


class MoviePosterLink extends StatelessWidget {
  final Movie movie;

  const MoviePosterLink({super.key, required this.movie});


  @override
  Widget build(BuildContext context) {
    final random = Random();

    return FadeInUp(
      // styles animations
      from: random.nextInt(100) + 80, // [80, 100]
      delay: Duration(milliseconds: random.nextInt(450) + 0),

      child: GestureDetector(
        onTap: () => context.push('/home/0/movie/${movie.id}'),
    
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          
          child: FadeInImage(
            fit: BoxFit.cover,
            placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
            image: NetworkImage(movie.posterPath),
          ),
        ),
      ),
    );
  }

}