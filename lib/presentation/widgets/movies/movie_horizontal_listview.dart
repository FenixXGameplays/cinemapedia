import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/movie.dart';

class MovieHorizontalListview extends StatelessWidget {
  final List<Movie> movies;
  final String? label;
  final String? date;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview({
    super.key,
    required this.movies,
    this.label,
    this.date,
    this.loadNextPage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (label != null && date != null)
            _TitleHorizontal(label: label, date: date),
          Expanded(
              child: ListView.builder(
                //controller: scrollController,
                itemCount: movies.length,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return FadeInRight(child: _Slide(movie: movies[index]));
                },
              )
            )
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ImageHorizontal(movie: movie),
          const SizedBox( height:  5),

          _TitleMovie(movie: movie, titleStyle: titleStyle),

          Row(
            children: [
              Icon(Icons.star_half_outlined, color: Colors.yellow.shade800,),
              const SizedBox(width: 3,),
              Text("${movie.voteAverage}", style: titleStyle.bodyMedium?.copyWith(color: Colors.yellow.shade800),),
              const SizedBox(width: 10,),
              Text(HumanFormat.numberFormatted(movie.popularity), style: titleStyle.bodySmall,)
            ],
          )
        ],
      ),
    );
  }
}

class _TitleMovie extends StatelessWidget {
  const _TitleMovie({
    super.key,
    required this.movie,
    required this.titleStyle,
  });

  final Movie movie;
  final TextTheme titleStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Text(movie.title,
      maxLines: 2,
      style: titleStyle.titleSmall,
      ),
    );
  }
}

class _ImageHorizontal extends StatelessWidget {
  const _ImageHorizontal({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          movie.posterPath,
          fit: BoxFit.cover,
          width: 150,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress != null) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
    
            return FadeIn(child: child);
          },
        ),
      ),
    );
  }
}

class _TitleHorizontal extends StatelessWidget {
  final String? label;
  final String? date;
  const _TitleHorizontal({
    required this.label,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (label != null)
            Text(
              label!,
              style: titleStyle,
            ),
          const Spacer(),
          if (date != null)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text(date!),
            )
        ],
      ),
    );
  }
}
