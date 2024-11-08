import 'package:cinemapedia/presentation/providers/movies/similar_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';


final similarMoviesProvider = StateNotifierProvider<SimilarFilmNotifier, Map<String, List<Movie>>>((ref) {

  final fetchMoreMovies = ref.watch(similarRepositoryProvider).getSimilarsById;
  return SimilarFilmNotifier(fetchMoreSimilars: fetchMoreMovies);
});

typedef SimilarCallback = Future<List<Movie>> Function(String id, {int page});

class SimilarFilmNotifier extends StateNotifier<Map<String, List<Movie>>>{
  int currentPage = 0;
  bool isLoading = false;
  SimilarCallback fetchMoreSimilars;

  SimilarFilmNotifier({required this.fetchMoreSimilars}): super({});

  Future<void> loadNextSimilars(String movieId) async {
    if(state[movieId] != null) return;

    if(isLoading) return;
    isLoading = true;
    currentPage++;

    final List<Movie> similars = await fetchMoreSimilars(movieId, page: currentPage);

    state = {...state, movieId: similars};

    isLoading = false;
  }
}