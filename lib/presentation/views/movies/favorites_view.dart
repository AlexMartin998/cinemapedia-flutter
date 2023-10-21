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
    final favoriteMoviesMap = ref.watch(favoriteMoviesProvider);
    final favoriteMoviesList = favoriteMoviesMap.values.toList();


    return Scaffold(
      body: MovieMasonry(
        loadNextPage: loadNextPage,

        movies: favoriteMoviesList,
      ),
    );
  }
}
