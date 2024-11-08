

import 'package:cinemapedia/domain/datasources/similar_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/similar_repositories.dart';

class SimilarRepositoryImpl  extends SimilarRepositories{
  final SimilarDatasource datasource;

  SimilarRepositoryImpl({required this.datasource});
  @override
  Future<List<Movie>> getSimilarsById(String id, {int page = 1}) {
    return datasource.getSimilarsById(id, page: page);
  }
  
}