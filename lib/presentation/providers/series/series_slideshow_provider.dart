import 'package:cinemapedia_220031/domain/entities/series.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'series_providers.dart';

final seriesSlideShowProvider =  
    Provider<List<Series>>((ref) {
      final topRatedSeries = ref.watch(topRatedSeriesProvider);
      if (topRatedSeries.isEmpty) return [];
      
      // Filtrar SOLO series con backdrop válido
      final validSeries = topRatedSeries
        .where((serie) => serie.backdropPath.isNotEmpty)
        .toList();
      
      if (validSeries.isEmpty) return [];
      final count = validSeries.length > 10 ? 10 : validSeries.length;
      return validSeries.sublist(0, count);
});