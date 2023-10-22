import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinema_pedia/presentation/providers/providers.dart';
import 'package:cinema_pedia/presentation/widgets/widgets.dart';



class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}


// keepAlive Mixin
class FavoritesViewState extends ConsumerState<FavoritesView> with AutomaticKeepAliveClientMixin {
  bool isLastPage = false;
  bool isLoading = false;


  @override
  void initState() {  // ngOnInit() :v
    super.initState();

    loadNextPage();
  }


  void loadNextPage() async {
    if (isLastPage || isLoading) return;
    isLoading = true;

    final movies = await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;

    if (movies.isEmpty) isLastPage = true;
  }


  @override
  Widget build(BuildContext context) {
    super.build(context); // lo req el mixin

    final favoriteMoviesMap = ref.watch(favoriteMoviesProvider);
    final favoriteMoviesList = favoriteMoviesMap.values.toList();

    if (favoriteMoviesList.isEmpty) {
      final color = Theme.of(context).colorScheme;
      return Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.favorite_outline_sharp, size: 60, color: color.primary),
          Text('Ohh no!', style: TextStyle(fontSize: 30, color: color.primary)),
          const Text('No tienes peliculas favoritas', style: TextStyle(
            fontSize: 20
          )),
          const SizedBox(height: 21),

          FilledButton.tonal(
            onPressed: () => context.go('/home/0'),
            child: const Text("Descubre nuevos titulos"),
          ),
        ],
      ),
      );
    }


    return Scaffold(
      body: MovieMasonry(
        loadNextPage: loadNextPage,

        movies: favoriteMoviesList,
      ),
    );
  }


  // // keep alive
  @override
  bool get wantKeepAlive => true;

}
