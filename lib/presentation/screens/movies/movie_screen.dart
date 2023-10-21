import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import 'package:cinema_pedia/domain/entities/movie.dart';
import 'package:cinema_pedia/presentation/providers/providers.dart';



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

    // disparan las   http req   con la clean arch
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMoviePorivder.notifier).loadActors(widget.movieId);
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
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(), // remueve rebote ios/android

        slivers: [ // W con el comportamiento del Scroll
          /* AppBar */
          _CustomSliverAppBar(movie: movie), // must be a Sliver

          /* Movie Details */
          SliverList(delegate: SliverChildBuilderDelegate(
            (context, index) => _MovieDetails(movie: movie),
            childCount: 1, // veces q se repite el content
          )),
        ],
      ),
    );
  }
}


// // // lo crea aqui x simplicidad ya q solo se va a usar aqui este provider
// // FutureProvider: Resolver Async Tasks to return a state
// debo consultar en db para saber el state y retornarlo. Como es Async uso FutureProvider
// .family() recibir Args en el provider
final isFavoriteProvider = FutureProvider.family((ref, int movieId) {
  final localStorageRespository = ref.watch(localStorageRepositoryProvider);
  return localStorageRespository.isMovieFavorite(movieId);
});



class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // future provider
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));

    // size real del mobile
    final size = MediaQuery.of(context).size;

    // customize gradients
    // final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;


    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,

      // // I Like it Btn
      actions: [
        IconButton(
          onPressed: () async {
            await ref.read(favoriteMoviesProvider.notifier).toggleFavorite(movie);

            // invalida para regresar al init state: el init state es 1 future q no se resuelve, al invalidarlo lo vuelve a hacer la req
            ref.invalidate(isFavoriteProvider(movie.id));
          }, 
          icon: isFavoriteFuture.when(
            loading: () => const CircularProgressIndicator(), // no se vera xq es muy rapido
            data: (isFavorite) => isFavorite
              ? const Icon(Icons.favorite_rounded, color: Colors.red)
              : const Icon(Icons.favorite_border),
            error: (_, __) => throw UnimplementedError(),
          ),
        ),
      ],

      // same goBack btn
      leading: IconButton(
        onPressed: (){context.pop();}, // pop() <- go_router
        icon: const Icon(Icons.arrow_back_ios_new_outlined)
      ),
      
      // content
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.fromLTRB(12, 0, 0, 12),
        centerTitle: false,
        
        /* title: Text(
          movie.title,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        ), */

        background: Stack( // 1 sobre otro
          children: [
            /* image */
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,

                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return FadeIn(child: child);

                  return const SizedBox();
                },
              ),
            ),

            /* ** Gradient ** */
            // // Favorite gradient
            const _CustomGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0, 0.2],
              colors: [
                Colors.black54,
                Colors.transparent,
              ]
            ),
            // // Back arrow gradient
            const _CustomGradient(
              begin: Alignment.topLeft,
              stops: [0.0, 0.3],
              colors: [
                Colors.black87,
                Colors.transparent,
              ]
            ),

            // // Bottom
            const _CustomGradient(
              // de arriba abajo
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.75, 1.0],
              colors: [
                Colors.transparent,
                Colors.black87,
                // scaffoldBackgroundColor // same color of theme
              ]
            ),
            
          ],
        ),
        
      ),
    );
  }
}



class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({required this.movie});


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(9),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(21),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * .3,
                ),
              ),
              const SizedBox(width: 10),

              /* description */
              SizedBox(
                width: (size.width - 40) * .7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: textStyles.titleLarge),
                    Text(movie.overview),
                  ],
                ),
              ),
            ],
          ),
        ),

        /* genres */
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap( // children aligned to the start
            children: [
              ...movie.genreIds.map((gender) => Container(
                margin: const EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text(gender),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
              )),
            ],
          ),
        ),


        /* actors */
        _ActorsByMovie(movieId: movie.id.toString()),



        // ensure visibility (just margin)
        const SizedBox(height: 24),
      ],
    );
  }
}



// riverpod provider consumer stateless
class _ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const _ActorsByMovie({required this.movieId});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // trhough provider (state): <Map<String, List<Actor>>
    final actors = ref.watch(actorsByMoviePorivder)[movieId];
    if(actors == null) { // loading actors 'cause all movies have actors
      return const Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    // como evaluo con el loader se q aqui ya tengo actores
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(), // rebote ios/android
        itemCount: actors.length,

        itemBuilder: (context, index) {
          final actor = actors[index];

          return Container(
            padding: const EdgeInsets.all(8),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                /* image */
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 5),

                /* name */
                Text(actor.name, maxLines: 2),
                Text(actor.character ?? '',
                  maxLines: 2,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    // >2 lines: ...
                    overflow: TextOverflow.ellipsis
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}



class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;


  const _CustomGradient({
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
    required this.stops,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand( // take all space
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            stops: stops,
            colors: colors,
          ),
        ),
      ),
    );
  }
}