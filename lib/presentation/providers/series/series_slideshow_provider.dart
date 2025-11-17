import 'package:cinemapedia_220031/domain/entities/series.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'series_providers.dart';

final seriesSlideShowProvider =  
    Provider<List<Series>>((ref) {
      final airingTodaySeries = ref.watch(airingTodaySeriesProvider);
      if (airingTodaySeries.isEmpty) return [];
      return airingTodaySeries.sublist(0, 6);
});