import 'package:cinemapedia/domain/repositories/local_storage_repositories.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/movie.dart';


final favoriteMovieProvider = StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRepositories = ref.watch(localStorageProvider);

  return StorageMoviesNotifier(localStorageRepositories: localStorageRepositories);

});

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalStorageRepositories localStorageRepositories;
  StorageMoviesNotifier({required this.localStorageRepositories}) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies = await localStorageRepositories.loadMovie(offset: page * 15, limit: 20);
    page++;
    final tempMoviesMap = <int, Movie>{};
    for (final movie in movies){
      tempMoviesMap[movie.id] = movie;
    }

    state = {...state, ...tempMoviesMap};
    return movies;

  }

  Future<void> toggleFavorite(Movie movie)async{
    await localStorageRepositories.toggleFavorite(movie);
    final bool isMovieInFavorites = state[movie.id] != null;

    if(isMovieInFavorites){
      state.remove(movie.id);
      state = {...state};
    }else {
      state = {...state, movie.id : movie};
    }
  }
}
