import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_format.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;
  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();
  StreamController<bool> isLoadingMovies = StreamController.broadcast();
  Timer? _debouceTimer;

  SearchMovieDelegate({required this.searchMovies}) : super();

  void _onQueryChanged(String query) {
    isLoadingMovies.add(true);
    if (_debouceTimer?.isActive ?? false) _debouceTimer!.cancel();

    _debouceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        debounceMovies.add([]);
        return;
      }

      final movies = await searchMovies(query);
      debounceMovies.add(movies);
      isLoadingMovies.add(false);
    });
  }

  void clearStreams() {
    debounceMovies.close();
  }

  @override
  String get searchFieldLabel => 'Buscar Película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
          initialData: false,
          stream: isLoadingMovies.stream,
          builder: (context, snapshot) {
            if (snapshot.data ?? false) {
              return SpinPerfect(
                duration: const Duration(milliseconds: 800),
                infinite: true,
                animate: query.isNotEmpty,
                child: IconButton(
                  onPressed: () => query = '',
                  icon: const Icon(Icons.refresh_rounded),
                ),
              );
            }
            return FadeIn(
              animate: query.isNotEmpty,
              child: IconButton(
                onPressed: () => query = '',
                icon: const Icon(Icons.clear),
              ),
            );
          }),
      
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStreams();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    _onQueryChanged(query);
    return _ShowMovie(debounceMovies: debounceMovies);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return _ShowMovie(debounceMovies: debounceMovies);
  }
}

class _ShowMovie extends StatelessWidget {
  const _ShowMovie({
    required this.debounceMovies,
  });

  final StreamController<List<Movie>> debounceMovies;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: debounceMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return _MovieItem(
                movie: movies[index],
              );
            });
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  const _MovieItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () => context.push('/movie-screen/${movie.id}'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: (size.width - 10) * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textStyle.titleMedium,
                    maxLines: 2,
                  ),
                  Text(
                    movie.overview,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.star_half_outlined,
                        color: Colors.yellow.shade800,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        HumanFormat.numberFormatted(movie.voteAverage, 1),
                        style: textStyle.bodyMedium
                            ?.copyWith(color: Colors.yellow.shade800),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
