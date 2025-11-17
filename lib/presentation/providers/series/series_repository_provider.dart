import 'package:cinemapedia_220031/infrastructure/datasources/moviedb_series_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_220031/infrastructure/repositories/series_repository_impl.dart';

final seriesRepositoryProvider = Provider((ref) {
  return SeriesRepositoryImpl( MoviedbSeriesDatasource() );
});