import '../entities/movie.dart';

abstract class SimilarDatasource {
    Future<List<Movie>> getSimilarsById(String id,{int page = 1});

}