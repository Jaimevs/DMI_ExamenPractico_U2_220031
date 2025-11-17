import 'package:cinemapedia_220031/domain/entities/series.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'series_providers.dart';

final seriesSlideShowProvider =  
    Provider<List<Series>>((ref) {
      final topRatedSeries = ref.watch(topRatedSeriesProvider);
      if (topRatedSeries.isEmpty) return [];
      return topRatedSeries.sublist(0, 10.clamp(0, topRatedSeries.length));
});