import 'dart:async';
import 'package:cinemapedia_220031/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia_220031/domain/entities/series.dart';

typedef SearchSeriesCallback = Future<List<Series>> Function(String query);

class SearchSeriesDelegate extends SearchDelegate<Series?> {
  final SearchSeriesCallback searchSeries;
  List<Series> initialSeries;

  StreamController<List<Series>> debouncedSeries = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debounceTimer;

  SearchSeriesDelegate({
    required this.searchSeries,
    required this.initialSeries
  }) : super(
    searchFieldLabel: 'Buscar series',
  );

  void clearStreams() {
    debouncedSeries.close();
    isLoadingStream.close();
  }

  void _onQueryChanged(String query) {
    isLoadingStream.add(true);

    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final series = await searchSeries(query);
      initialSeries = series;
      debouncedSeries.add(series);
      isLoadingStream.add(false);
    });
  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialSeries,
      stream: debouncedSeries.stream,
      builder: (context, snapshot) {
        final series = snapshot.data ?? [];

        return ListView.builder(
          itemCount: series.length,
          itemBuilder: (context, index) => _SeriesItem(
            series: series[index],
            onSeriesSelected: (context, serie) {
              clearStreams();
              close(context, serie);
            },
          ),
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              spins: 10,
              infinite: true,
              child: IconButton(
                onPressed: () => query = '',
                icon: const Icon(Icons.refresh_rounded),
              ),
            );
          }

          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
              onPressed: () => query = '',
              icon: const Icon(Icons.clear),
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return buildResultsAndSuggestions();
  }
}

class _SeriesItem extends StatelessWidget {
  final Series series;
  final Function onSeriesSelected;

  const _SeriesItem({
    required this.series,
    required this.onSeriesSelected
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onSeriesSelected(context, series);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            // Image
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  series.posterPath,
                  loadingBuilder: (context, child, loadingProgress) =>
                      FadeIn(child: child),
                ),
              ),
            ),

            const SizedBox(width: 10),

            // Description
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(series.name, style: textStyles.titleMedium),

                  (series.overview.length > 100)
                      ? Text('${series.overview.substring(0, 100)}...')
                      : Text(series.overview),

                  Row(
                    children: [
                      Icon(
                        Icons.star_half_rounded,
                        color: Colors.yellow.shade800,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        HumanFormats.number(series.voteAverage),
                        style: textStyles.bodyMedium!.copyWith(
                          color: Colors.yellow.shade900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}