import 'package:cinema_pedia/domain/entities/actor.dart';
import 'package:cinema_pedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/* 
  * State:
  {
    '23123': List<Actor>(),
    '13453': List<Actor>(),
  }
*/


// // // StateNotifierProvider to be used with StateNotifier
final actorsByMoviePorivder = StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>((ref) {
  final getActorsByMovie = ref.watch(actorsRepositoryProvider).getActorsByMovie; // no se invoca
  
  return ActorsByMovieNotifier(getActors: getActorsByMovie);
});




// // // StateNotifier Generico para varios Providers de != useCases
typedef GetActorsCallback = Future<List<Actor>>Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;

  ActorsByMovieNotifier({
    required this.getActors,
  }) : super({});


  // generico para usar cualquier useCase
  Future<void> loadActors(String movieId) async {
    // si ya tengo la movie en cache (prev req), NO fetch it
    if (state[movieId] != null) return;

    final List<Actor> actors = await getActors(movieId);

    state = { ...state, movieId: actors };
  }

}
