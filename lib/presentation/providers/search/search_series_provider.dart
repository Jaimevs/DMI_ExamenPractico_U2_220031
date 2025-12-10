import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_220031/domain/entities/series.dart';
import 'package:cinemapedia_220031/presentation/providers/series/series_repository_provider.dart';

// 🔹 Provider del query actual de búsqueda de series
final searchQuerySeriesProvider = NotifierProvider<SearchQuerySeriesNotifier, String>(
  SearchQuerySeriesNotifier.new,
);

class SearchQuerySeriesNotifier extends Notifier<String> {
  @override
  String build() => '';

  void update(String newQuery) {
    state = newQuery;
  }
}

// 🔹 Provider principal de series buscadas
final searchedSeriesProvider = NotifierProvider<SearchedSeriesNotifier, List<Series>>(
  SearchedSeriesNotifier.new,
);

// 🔹 Definición del tipo callback
typedef SearchSeriesCallback = Future<List<Series>> Function(String query);

// 🔹 Notifier para búsqueda de series (Riverpod 3.x)
class SearchedSeriesNotifier extends Notifier<List<Series>> {
  late final SearchSeriesCallback searchSeries;

  @override
  List<Series> build() {
    final seriesRepository = ref.watch(seriesRepositoryProvider);
    searchSeries = seriesRepository.searchSeries;
    return [];
  }

  Future<List<Series>> searchSeriesByQuery(String query) async {
    final List<Series> series = await searchSeries(query);
    ref.read(searchQuerySeriesProvider.notifier).update(query);
    state = series;
    return series;
  }
}