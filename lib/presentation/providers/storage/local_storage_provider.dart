import 'package:cinemapedia/infrastucture/datasources/isar_datasource.dart';
import 'package:cinemapedia/infrastucture/repositories/local_storage_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(datasource: IsarDatasource());
});