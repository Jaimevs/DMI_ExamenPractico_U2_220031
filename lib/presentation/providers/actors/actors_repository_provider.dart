import 'package:cinemapedia_220031/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:cinemapedia_220031/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(ActorMovieDbDatasource());
});