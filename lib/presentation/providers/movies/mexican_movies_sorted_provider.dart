import 'package:cinemapedia_220031/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'movies_providers.dart';

final mexicanMoviesSortedProvider = Provider<List<Movie>>((ref) {
  final mexicanMovies = ref.watch(mexicanMoviesProvider);
  
  final sortedMovies = List<Movie>.from(mexicanMovies);
  sortedMovies.sort((a, b) => b.releaseDate.compareTo(a.releaseDate));
  
  return sortedMovies;
});