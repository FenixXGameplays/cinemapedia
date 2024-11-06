import '../entities/actor.dart';

abstract class ActorsRepositories {
  Future<List<Actor>> getActorsByMovie(String movieId);
}