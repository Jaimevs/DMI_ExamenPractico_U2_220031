import 'package:dio/dio.dart';
import 'package:cinemapedia_220031/config/constants/environment.dart';
import 'package:cinemapedia_220031/domain/datasources/series_datasource.dart';
import 'package:cinemapedia_220031/infrastructure/mappers/series_mapper.dart';
import 'package:cinemapedia_220031/infrastructure/models/moviedb/seriesdb_response.dart';
import 'package:cinemapedia_220031/domain/entities/series.dart';
import 'package:cinemapedia_220031/infrastructure/models/moviedb/series_details.dart';

class MoviedbSeriesDatasource extends SeriesDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.theMovieDbKey,
      'language': 'es-MX'
    }
  ));

  @override
  Future<List<Series>> getAiringToday({int page = 1}) async {
    final response = await dio.get('/tv/on_the_air',
    queryParameters: {
      'page': page,
    });
    final seriesDBResponse = SeriesDbResponse.fromJson(response.data);
    
    final List<Series> series = seriesDBResponse.results
      .where((seriesdb) => seriesdb.posterPath.isNotEmpty)
      .map((seriesdb) => SeriesMapper.seriesDBToEntity(seriesdb))
      .toList();
    
    return series;
  }

  @override
  Future<List<Series>> getPopular({int page = 1}) async {
    final response = await dio.get('/tv/popular',
    queryParameters: {
      'page': page,
    });
    final seriesDBResponse = SeriesDbResponse.fromJson(response.data);
    
    final List<Series> series = seriesDBResponse.results
      .where((seriesdb) => seriesdb.posterPath.isNotEmpty)
      .map((seriesdb) => SeriesMapper.seriesDBToEntity(seriesdb))
      .toList();
    
    return series;
  }

  @override
  Future<List<Series>> getTopRated({int page = 1}) async {
    final response = await dio.get('/tv/top_rated',
    queryParameters: {
      'page': page,
    });
    final seriesDBResponse = SeriesDbResponse.fromJson(response.data);
    
    final List<Series> series = seriesDBResponse.results
      .where((seriesdb) => seriesdb.posterPath.isNotEmpty && seriesdb.backdropPath.isNotEmpty)
      .map((seriesdb) => SeriesMapper.seriesDBToEntity(seriesdb))
      .toList();
    
    return series;
  }

  @override
  Future<List<Series>> getUpcoming({int page = 1}) async {
    final response = await dio.get('/discover/tv',
    queryParameters: {
      'page': page,
      'sort_by': 'first_air_date.desc',
    });
    final seriesDBResponse = SeriesDbResponse.fromJson(response.data);

    final List<Series> series = seriesDBResponse.results
      .where((seriesdb) => seriesdb.posterPath.isNotEmpty)
      .map((seriesdb) => SeriesMapper.seriesDBToEntity(seriesdb))
      .toList();

    return series;
  }

  @override
  Future<List<Series>> getMexicanSeries({int page = 1}) async {
    final response = await dio.get('/discover/tv',
    queryParameters: {
      'page': page,
      'with_original_language': 'es',
      'region': 'MX',
    });
    final seriesDBResponse = SeriesDbResponse.fromJson(response.data);

    final List<Series> series = seriesDBResponse.results
      .where((seriesdb) => seriesdb.posterPath.isNotEmpty)
      .map((seriesdb) => SeriesMapper.seriesDBToEntity(seriesdb))
      .toList();

    return series;
  }

  @override
Future<Series> getSeriesById(String id) async {
  final response = await dio.get('/tv/$id');
  if (response.statusCode != 200) {
    throw Exception('Series with id: $id not found');
  }

  final seriesDetails = SeriesDetails.fromJson(response.data);
  final Series series = SeriesMapper.seriesDetailsToEntity(seriesDetails);
  return series;
}
  
}