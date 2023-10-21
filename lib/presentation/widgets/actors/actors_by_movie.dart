import 'package:animate_do/animate_do.dart';
import 'package:cinema_pedia/presentation/providers/actors/actors_by_movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// riverpod: provider consumer for stateless widgets
class ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const ActorsByMovie({super.key, required this.movieId});


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

                    child: FadeInImage(
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                      placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
                      image: NetworkImage(
                        actor.profilePath,
                      ),
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
