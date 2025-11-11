import 'package:cinemapedia_220031/domain/entities/movie.dart';

abstract class MoviesRepository {

  // obtener la lista de peliculas actualmente en cartelera

  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({ int page = 1 });
  Future<List<Movie>> getTopRated({ int page = 1 });
  Future<List<Movie>> getUpcoming({ int page = 1 });
  Future<List<Movie>> getMexicanMovies({ int page = 1 });

}