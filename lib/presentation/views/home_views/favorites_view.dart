import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
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
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;
    final movies =
        await ref.read(favoriteMovieProvider.notifier).loadNextPage();
    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritesMovies = ref.watch(favoriteMovieProvider).values.toList();
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
        body: favoritesMovies.isNotEmpty
            ? MovieMasonry(
                movies: favoritesMovies,
                loadNextPage: loadNextPage,
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border_outlined,
                      color: colors.primary,
                      size: 50,
                    ),
                    Text(
                      "Ohhh Noo!",
                      style: TextStyle(
                        color: colors.primary,
                        fontSize: 30,
                      ),
                    ),
                    const Text(
                      "No tienes películas Favorítas",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ));
  }
}
