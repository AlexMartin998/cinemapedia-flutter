import 'package:cinema_pedia/presentation/providers/providers.dart';
import 'package:cinema_pedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}


class FavoritesViewState extends ConsumerState<FavoritesView> {

  @override
  void initState() {
    super.initState();

    ref.read(favoriteMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMoviesMap = ref.watch(favoriteMoviesProvider);
    final favoriteMoviesList = favoriteMoviesMap.values.toList();


    return Scaffold(
      body: MovieMasonry(movies: favoriteMoviesList),
    );
  }
}
