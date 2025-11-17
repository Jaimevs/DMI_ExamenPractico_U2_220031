import 'package:cinemapedia_220031/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'movies_providers.dart';

final upcomingThisMonthProvider = Provider<List<Movie>>((ref) {
  final upcomingMovies = ref.watch(upcomingMoviesProvider);
  final now = DateTime.now();
  
  final thisMonthMovies = upcomingMovies.where((movie) {
    return movie.releaseDate.year == now.year && 
           movie.releaseDate.month == now.month;
  }).toList();
  
  return thisMonthMovies;
});