import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'movies_providers.dart';

final loadingProgressProvider = Provider<int>((ref) {
  // Monitoreamos cada provider de películas
  final nowPlaying = ref.watch(nowPlayingMoviesProvider);
  final upcoming = ref.watch(upcomingMoviesProvider);
  final popular = ref.watch(popularMoviesProvider);
  final topRated = ref.watch(topRatedMoviesProvider);
  final mexican = ref.watch(mexicanMoviesProvider);

  // Contamos cuántos providers ya tienen datos (no están vacíos)
  int loadedProviders = 0;
  
  if (nowPlaying.isNotEmpty) loadedProviders++;
  if (upcoming.isNotEmpty) loadedProviders++;
  if (popular.isNotEmpty) loadedProviders++;
  if (topRated.isNotEmpty) loadedProviders++;
  if (mexican.isNotEmpty) loadedProviders++;

  // Calculamos el porcentaje (cada provider = 20%)
  // 5 providers * 20% = 100%
  final progress = (loadedProviders * 20);

  return progress;
});