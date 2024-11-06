//SOLO LECTURA
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../infrastucture/datasources/actor_moviedb_datasource.dart';
import '../../../../infrastucture/repositories/actor_repository_impl.dart';

final castRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(datasource: ActorMoviedbDatasource());
});