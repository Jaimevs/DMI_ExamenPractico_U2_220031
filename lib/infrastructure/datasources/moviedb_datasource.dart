import 'package:dio/dio.dart';
import 'package:cinemapedia_220031/config/constants/environment.dart';
import 'package:cinemapedia_220031/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia_220031/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia_220031/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:cinemapedia_220031/domain/entities/movie.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.theMovieDbKey,
      'language': 'es-MX'
    }
  ));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing',
    queryParameters: {
      'page': page,
    });
    final movieDBResponse = MovieDbResponse.fromJson(response.data);
    
    final List<Movie> movies = movieDBResponse.results
      .where((moviedb) => moviedb.posterPath != 'no-poster')
      .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
      .toList();
    
    return movies;
  }

 @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get('/movie/popular',
    queryParameters: {
      'page': page,
    });
    final movieDBResponse = MovieDbResponse.fromJson(response.data);
    
    final List<Movie> movies = movieDBResponse.results
      .where((moviedb) => moviedb.posterPath != 'no-poster')
      .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
      .toList();
    
    return movies;
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming',
    queryParameters: {
      'page': page,
    });
    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDBResponse.results
      .where((moviedb) => moviedb.posterPath != 'no-poster')
      .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
      .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get('/movie/top_rated',
    queryParameters: {
      'page': page,
    });
    final movieDBResponse = MovieDbResponse.fromJson(response.data);
    
    final List<Movie> movies = movieDBResponse.results
      .where((moviedb) => moviedb.posterPath != 'no-poster')
      .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
      .toList();
    
    return movies;
  }

  @override
  Future<List<Movie>> getMexicanMovies({int page = 1}) async {
    final response = await dio.get('/discover/movie',
    queryParameters: {
      'page': page,
      'region': 'MX',
      'with_original_language': 'es'
    });
    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDBResponse.results
      .where((moviedb) => moviedb.posterPath != 'no-poster')
      .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
      .toList();

    return movies;
  }
  
}