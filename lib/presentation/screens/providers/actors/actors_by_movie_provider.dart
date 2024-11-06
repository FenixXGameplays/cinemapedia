import 'package:cinemapedia/presentation/screens/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/entities/actor.dart';

final actorsByMovieProvider = StateNotifierProvider<ActorsMapNotifier, Map<String, List<Actor>>>((ref) {
  final fetchActorMovie = ref.watch(castRepositoryProvider).getActorsByMovie;
  return ActorsMapNotifier(getActors: fetchActorMovie);
});



typedef GetActorsCallback = Future<List<Actor>>Function(String movieId);

class ActorsMapNotifier extends StateNotifier<Map<String, List<Actor>>> {

final GetActorsCallback getActors;

  ActorsMapNotifier({required this.getActors}): super({});


  Future<void> loadActors(String movieId) async {
    if(state[movieId] != null) return;

    final List<Actor> actors = await getActors(movieId);

    state = {...state, movieId: actors};
  }

}