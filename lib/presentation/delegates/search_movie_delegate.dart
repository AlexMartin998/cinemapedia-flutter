import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import 'package:cinema_pedia/config/helpers/human_formats.dart';
import 'package:cinema_pedia/domain/entities/movie.dart';


typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {

  // viene de nuestro repository provider 
  final SearchMoviesCallback searchMovies;
  final List<Movie> initialMovies; // searchedMovies

  // // debounce
  // .broadcast() varios listeners: c/re-render se vuelve a subscribir
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  Timer? _debounceTimer; // like setTimeOut()

  SearchMovieDelegate({
    required this.searchMovies,
    required this.initialMovies,
  });

  // // debounce
  void crearStreams() {
    debouncedMovies.close();
  }

  void _onQueryChanged(String query) {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    } // clean timer

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async { 
        // fetch movies & emit them to Stream
        final movies = await searchMovies(query);
        debouncedMovies.add(movies);
      }
    );
  }


  @override
  String get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    
    return [
      FadeIn(
        animate: query.isNotEmpty, // like ifazo
        child: IconButton(
          // query nos lo da el SearchDelegate
          onPressed: () => query = '', // limpio el input
      
          icon: const Icon(Icons.clear),
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) { // leading like icon
    return IconButton(
      // close gracias al SearchDelegate (ctx, result): result es lo q se retorna al cerrar
      // como es el leading para go back, no retorno nada
      onPressed: () {
        crearStreams(); // limpiar los streams
        close(context, null);
      },
      
      icon: const Icon(Icons.arrow_back_ios_new_outlined),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query); // debounce
    
    return StreamBuilder(
      // future: seachMovies(query), // dispara la req
      initialData: initialMovies, // searchedMovies (avoid loading)
      stream: debouncedMovies.stream,

      builder: (context, snapshot) { // snapshot sabe lo q fluye
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,

          itemBuilder: (context, index) => _MovieItem(
            movie: movies[index],
            
            onMovieSelected: (context, movie) {
              crearStreams(); // limpiar los streams
              close(context, movie);
            }, // global in SearchDelegate
          ),
        );
      },
    );
  }

}



class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected; // xq aqui no tengo el close()

  const _MovieItem({required this.movie, required this.onMovieSelected});


  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    
    return GestureDetector( // detectar el tap
      onTap: () {
        onMovieSelected(context, movie);
        // context.push('/movie/${movie.id}'); // no cierra el searcher y permite regresar a el
      },

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            /* Image */
            SizedBox( //  dar size dentor del row
              width: size.width * .2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return FadeIn(child: child);
    
                    return const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
    
            /* Description */
            SizedBox(
              width: size.width * .7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
    
                children: [
                  // title
                  Text(movie.title, style: textStyles.titleMedium),
    
                  // overview
                  (movie.overview.length > 100)
                    ? Text('${movie.overview.substring(0, 100)}...')
                    : Text(movie.overview),
    
                  // stars
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded, color: Colors.yellow.shade800),
                      const SizedBox(width: 6),
                      Text(
                        HumanFormats.number(movie.voteAverage, 1),
                        style: textStyles.bodyMedium!.copyWith(color: Colors.yellow.shade900),
                      ),
    
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


