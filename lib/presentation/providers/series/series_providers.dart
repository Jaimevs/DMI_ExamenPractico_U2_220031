import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_220031/domain/entities/series.dart';
import 'package:cinemapedia_220031/presentation/providers/series/series_repository_provider.dart';

typedef SeriesCallback = Future<List<Series>> Function({int page});

final airingTodaySeriesProvider =
    NotifierProvider<SeriesNotifier, List<Series>>(
      () => SeriesNotifier(
        (ref) => ref.watch(seriesRepositoryProvider).getAiringToday,
      ),
    );

final popularSeriesProvider =
    NotifierProvider<SeriesNotifier, List<Series>>(
      () => SeriesNotifier(
        (ref) => ref.watch(seriesRepositoryProvider).getPopular,
      ),
    );

final topRatedSeriesProvider =
    NotifierProvider<SeriesNotifier, List<Series>>(
      () => SeriesNotifier(
        (ref) => ref.watch(seriesRepositoryProvider).getTopRated,
      ),
    );

final upcomingSeriesProvider =
    NotifierProvider<SeriesNotifier, List<Series>>(
      () => SeriesNotifier(
        (ref) => ref.watch(seriesRepositoryProvider).getUpcoming,
      ),
    );

class SeriesNotifier extends Notifier<List<Series>> {
  final SeriesCallback Function(Ref ref) _callbackBuilder;
  late final SeriesCallback fetchMoreSeries;

  SeriesNotifier(this._callbackBuilder);

  int currentPage = 0;
  bool isLoading = false;

  @override
  List<Series> build() {
    fetchMoreSeries = _callbackBuilder(ref);
    return [];
  }

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;

    currentPage++;
    final series = await fetchMoreSeries(page: currentPage);

    state = [...state, ...series];

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}