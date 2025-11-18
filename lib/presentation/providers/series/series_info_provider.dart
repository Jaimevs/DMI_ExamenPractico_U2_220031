import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_220031/domain/entities/series.dart';
import 'package:cinemapedia_220031/presentation/providers/series/series_repository_provider.dart';

// 🔹 Provider principal
final seriesInfoProvider = NotifierProvider<SeriesMapNotifier, Map<String, Series>>(
  SeriesMapNotifier.new
);

// 🔹 Definición del tipo callback
typedef GetSeriesCallback = Future<Series> Function(String seriesId);

// 🔹 Notifier actualizado
class SeriesMapNotifier extends Notifier<Map<String, Series>> {
  late final GetSeriesCallback getSeries;

  @override
  Map<String, Series> build() {
    // Se obtiene el repositorio dentro del método build()
    final seriesRepository = ref.watch(seriesRepositoryProvider);
    getSeries = seriesRepository.getSeriesById;

    // Estado inicial vacío
    return {};
  }

  // 🔹 Método para cargar una serie si no está en el estado
  Future<void> loadSeries(String seriesId) async {
    if (state[seriesId] != null) return;

    final series = await getSeries(seriesId);
    state = {...state, seriesId: series};
  }
}