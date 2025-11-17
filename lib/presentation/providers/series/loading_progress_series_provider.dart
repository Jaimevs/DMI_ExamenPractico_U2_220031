import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'series_providers.dart';

final loadingProgressSeriesProvider = Provider<int>((ref) {
  final airingToday = ref.watch(airingTodaySeriesProvider);
  final upcoming = ref.watch(upcomingSeriesProvider);
  final popular = ref.watch(popularSeriesProvider);
  final topRated = ref.watch(topRatedSeriesProvider);
  final mexican = ref.watch(mexicanSeriesProvider);

  int loadedProviders = 0;
  
  if (airingToday.isNotEmpty) loadedProviders++;
  if (upcoming.isNotEmpty) loadedProviders++;
  if (popular.isNotEmpty) loadedProviders++;
  if (topRated.isNotEmpty) loadedProviders++;
  if (mexican.isNotEmpty) loadedProviders++;

  // 5 providers * 20% = 100%
  final progress = (loadedProviders * 20);

  return progress;
});