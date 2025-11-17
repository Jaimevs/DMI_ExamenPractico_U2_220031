import 'package:cinemapedia_220031/presentation/providers/series/initialLoading_series_provider.dart';
import 'package:cinemapedia_220031/presentation/providers/series/series_providers_export.dart';
import 'package:cinemapedia_220031/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SeriesScreen extends StatelessWidget {
  static const name = 'series-screen';

  const SeriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _SeriesView(),
      bottomNavigationBar: CustomBottomNavigationbar(),
    );
  }
}

class _SeriesView extends ConsumerStatefulWidget {
  const _SeriesView();

  @override
  _SeriesViewState createState() => _SeriesViewState();
}

class _SeriesViewState extends ConsumerState<_SeriesView> {
  @override
  void initState() {
    super.initState();
    ref.read(airingTodaySeriesProvider.notifier).loadNextPage();
    ref.read(popularSeriesProvider.notifier).loadNextPage();
    ref.read(topRatedSeriesProvider.notifier).loadNextPage();
    ref.read(upcomingSeriesProvider.notifier).loadNextPage();
    ref.read(mexicanSeriesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingSeriesProvider);
    if (initialLoading) return const FullscreenLoader();

    final airingToday = ref.watch(airingTodaySeriesProvider);
    final slideShowSeries = ref.watch(seriesSlideShowProvider);
    final popularSeries = ref.watch(popularSeriesProvider);
    final topRatedSeries = ref.watch(topRatedSeriesProvider);
    final upcomingSeries = ref.watch(upcomingSeriesProvider);
    final mexicanSeries = ref.watch(mexicanSeriesProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          flexibleSpace: const FlexibleSpaceBar(
            title: CustomAppbar(),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            SeriesSlideshow(series: slideShowSeries),
            SeriesHorizontalListview(
              series: airingToday,
              title: 'Series Actuales',
              subTitle: 'En emisión',
              loadNextPage: () => 
                ref.read(airingTodaySeriesProvider.notifier).loadNextPage(),
            ),
            SeriesHorizontalListview(
              series: upcomingSeries,
              title: 'Por Estrenarse',
              subTitle: 'Próximamente',
              loadNextPage: () => 
                ref.read(upcomingSeriesProvider.notifier).loadNextPage(),
            ),
            SeriesHorizontalListview(
              series: popularSeries,
              title: 'Series Populares',
              subTitle: 'Este mes',
              loadNextPage: () => 
                ref.read(popularSeriesProvider.notifier).loadNextPage(),
            ),
            SeriesHorizontalListview(
              series: topRatedSeries,
              title: 'Series Mejor Valoradas',
              subTitle: 'De todos los tiempos',
              loadNextPage: () => 
                ref.read(topRatedSeriesProvider.notifier).loadNextPage(),
            ),
            SeriesHorizontalListview(
              series: mexicanSeries,
              title: 'Series Mexicanas',
              subTitle: 'Producción local',
              loadNextPage: () => 
                ref.read(mexicanSeriesProvider.notifier).loadNextPage(),
            ),
            const SizedBox(height: 10)
          ]),
        ),
      ],
    );
  }
}