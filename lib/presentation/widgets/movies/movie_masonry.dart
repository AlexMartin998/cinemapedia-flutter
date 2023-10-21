import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';

import 'package:cinema_pedia/domain/entities/movie.dart';
import 'package:cinema_pedia/presentation/widgets/widgets.dart';


class MovieMasonry extends StatefulWidget {
  final List<Movie> movies;
  final VoidCallback? loadNextPage;

  const MovieMasonry({super.key, required this.movies, this.loadNextPage});

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}


class _MovieMasonryState extends State<MovieMasonry> {
  // infinite scroll
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // // // infinite scroll
    // // Listeners: se invoca/excecute muchas veces (0.00001) x tasa de refresco screen x eso tener vandera para las req http/db, en este caso el loader
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      // viene el callback
      if ((scrollController.position.pixels + 102) >= scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),

      child: MasonryGridView.count(
        crossAxisCount: 3, // columns #
        itemCount: widget.movies.length,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,

        controller: scrollController, // infinite scroll
    
        itemBuilder: (context, index) {
          // desordenar alineacion
          if (index == 1) {
            return Column(
              children: [
                const SizedBox(height: 40),
                MoviePosterLink(movie: widget.movies[index])
              ],
            );
          }

          return MoviePosterLink(movie: widget.movies[index]);
        },
      ),
    );
  }
}

