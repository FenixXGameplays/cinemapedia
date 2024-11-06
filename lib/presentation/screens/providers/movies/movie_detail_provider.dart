import 'package:cinemapedia/presentation/screens/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/entities/movie.dart';

final movieDetailProvider = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final fetchDetailMovie = ref.watch(movieRepositoryProvider).getDetailsId;
  return MovieMapNotifier(getMovie: fetchDetailMovie);
});



typedef GetMovieCallback = Future<Movie>Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {

final GetMovieCallback getMovie;

  MovieMapNotifier({required this.getMovie}): super({});


  Future<void> loadMovie(String movieId) async {
    if(state[movieId] != null) return;

    final movie = await getMovie(movieId);

    state = {...state, movieId: movie};
  }

}