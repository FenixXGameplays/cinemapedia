//SOLO LECTURA
import 'package:cinemapedia/infrastucture/datasources/similar_datasource.dart';
import 'package:cinemapedia/infrastucture/repositories/similar_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final similarRepositoryProvider = Provider((ref) {
  return SimilarRepositoryImpl(datasource: SimilarDbDatasource());
});