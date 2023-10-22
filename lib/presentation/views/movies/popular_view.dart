import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:cinema_pedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinema_pedia/presentation/widgets/movies/movie_masonry.dart';



class PopularView extends ConsumerStatefulWidget {

  const PopularView({super.key});

  @override
  PopularViewState createState() => PopularViewState();
}


// // keepAlive mixin req statefull widget
class PopularViewState extends ConsumerState<PopularView> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context ) {
    super.build(context);  // req by mixin

    final popularMovies = ref.watch( popularMoviesProvider );

    if ( popularMovies.isEmpty ) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    return Scaffold(
      body: MovieMasonry(
        loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage(),
        movies: popularMovies
      ),
    );
  }


  // keepAlive
  @override
  bool get wantKeepAlive => true;

}
