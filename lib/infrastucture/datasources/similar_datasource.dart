import 'package:cinemapedia/domain/datasources/similar_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:dio/dio.dart';

import '../../config/constants/environment.dart';
import '../mappers/movie_mapper.dart';
import '../models/moviedb/moviedb_response.dart';

class SimilarDbDatasource extends SimilarDatasource{

  final dio = Dio(
    BaseOptions(
      baseUrl: "https://api.themoviedb.org/3",
      queryParameters: {
        'api_key': Environment.movieDbKey,
        'language': 'es-ES',
      },
    ),
  );

    List<Movie> _jsonToMovie(Map<String, dynamic> json) {
    final movieDbResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDbResponse.results
        .where((movieDb) => movieDb.posterPath != 'no-poster')
        .map((movieDb) => MovieMapper.movieDBToEntity(movieDb))
        .toList();
    return movies;
  }

  @override
  Future<List<Movie>> getSimilarsById(String id, {int page = 1}) async {
    final response = await dio.get('/movie/$id/similar', queryParameters: {
      'page':page
    });
    if(response.statusCode != 200) throw Exception('Not Films Similar for $id');
    return _jsonToMovie(response.data);
  }
}