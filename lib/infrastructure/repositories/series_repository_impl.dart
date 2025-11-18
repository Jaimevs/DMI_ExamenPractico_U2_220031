import 'package:cinemapedia_220031/domain/datasources/series_datasource.dart';
import 'package:cinemapedia_220031/domain/entities/series.dart';
import 'package:cinemapedia_220031/domain/repositories/series_repository.dart';

class SeriesRepositoryImpl extends SeriesRepository {

  final SeriesDatasource datasource;
  SeriesRepositoryImpl(this.datasource);


  @override
  Future<List<Series>> getAiringToday({int page = 1}) {
    return datasource.getAiringToday(page: page);
  }

  @override
  Future<List<Series>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  @override
  Future<List<Series>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }

  @override
  Future<List<Series>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming(page: page);
  }

  @override
  Future<List<Series>> getMexicanSeries({int page = 1}) {
    return datasource.getMexicanSeries(page: page);
  }

  @override
Future<Series> getSeriesById(String id) {
  return datasource.getSeriesById(id);
}

}