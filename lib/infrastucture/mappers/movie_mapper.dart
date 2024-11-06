import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastucture/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastucture/models/moviedb/movie_from_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieFromMovieDB movieDb) => Movie(
        adult: movieDb.adult,
        backdropPath: movieDb.backdropPath != ''
            ? "https://image.tmdb.org/t/p/w500${movieDb.backdropPath}"
            : Environment.posterNotFound,
        genreIds: movieDb.genreIds.map((e) => e.toString()).toList(),
        id: movieDb.id,
        originalLanguage: movieDb.originalLanguage,
        originalTitle: movieDb.originalTitle,
        overview: movieDb.overview,
        popularity: movieDb.popularity,
        posterPath: movieDb.posterPath != ''
            ? "https://image.tmdb.org/t/p/w500${movieDb.posterPath}"
            : Environment.posterNotFound,
        releaseDate: movieDb.releaseDate,
        title: movieDb.title,
        video: movieDb.video,
        voteAverage: movieDb.voteAverage,
        voteCount: movieDb.voteCount,
      );

  static Movie movieDetailsToEntity(MovieDetails movie) => Movie(
        adult: movie.adult,
        backdropPath: movie.backdropPath != ''
            ? "https://image.tmdb.org/t/p/w500${movie.backdropPath}"
            : Environment.posterNotFound,
        genreIds: movie.genres.map((e) => e.name).toList(),
        id: movie.id,
        originalLanguage: movie.originalLanguage,
        originalTitle: movie.originalTitle,
        overview: movie.overview,
        popularity: movie.popularity,
        posterPath: movie.posterPath != ''
            ? "https://image.tmdb.org/t/p/w500${movie.posterPath}"
            : Environment.posterNotFound,
        releaseDate: movie.releaseDate,
        title: movie.title,
        video: movie.video,
        voteAverage: movie.voteAverage,
        voteCount: movie.voteCount,
      );
}
