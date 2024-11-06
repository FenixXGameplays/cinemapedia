
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastucture/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastucture/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

import '../../config/constants/environment.dart';

class ActorMoviedbDatasource extends ActorsDatasource{

final dio = Dio(
    BaseOptions(
      baseUrl: "https://api.themoviedb.org/3",
      queryParameters: {
        'api_key': Environment.movieDbKey,
        'language': 'es-ES',
      },
    ),
  );

List<Actor> _jsonToMovie(Map<String, dynamic> json) {
    final castResponse = CreditsResponse.fromJson(json);

    final List<Actor> actors = castResponse.cast
        .map((movieDb) => ActorMapper.castToEntity(movieDb))
        .toList();
    return actors;
  }

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async{
    final response = await dio.get('/movie/$movieId/credits');

    if(response.statusCode != 200) throw Exception('Movie with id: $movieId not found');

    

    return _jsonToMovie(response.data);
  }
}