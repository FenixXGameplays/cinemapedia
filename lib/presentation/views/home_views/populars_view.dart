import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularsView extends ConsumerStatefulWidget {
  const PopularsView({super.key});

  @override
  PopularsViewState createState() => PopularsViewState();
}

class PopularsViewState extends ConsumerState<PopularsView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final popularMovies = ref.watch(popularMoviesProvider);

    if(popularMovies.isEmpty){
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }

    return Scaffold(
      body: MovieMasonry(movies: popularMovies, loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage(),),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}