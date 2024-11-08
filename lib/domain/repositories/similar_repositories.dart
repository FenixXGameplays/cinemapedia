import '../entities/movie.dart';

abstract class SimilarRepositories {

  Future<List<Movie>> getSimilarsById(String id,{int page = 1});

}