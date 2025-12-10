import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cinemapedia_220031/domain/entities/movie.dart';
import 'package:cinemapedia_220031/domain/entities/series.dart';
import 'package:cinemapedia_220031/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia_220031/presentation/delegates/search_series_delegate.dart';
import 'package:cinemapedia_220031/presentation/providers/search/search_movies_provider.dart';
import 'package:cinemapedia_220031/presentation/providers/search/search_series_provider.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    // Detectar si estamos en la pantalla de series
    final currentLocation = GoRouterState.of(context).uri.toString();
    final isSeriesScreen = currentLocation.contains('/series');

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox(width: 5),
              Text('Cinemapedia-220031', style: titleStyle),
              const Spacer(),
              IconButton(
                onPressed: () {
                  if (isSeriesScreen) {
                    // Búsqueda de series
                    final searchedSeries = ref.read(searchedSeriesProvider);
                    final searchQuery = ref.read(searchQuerySeriesProvider);

                    showSearch<Series?>(
                      query: searchQuery,
                      context: context,
                      delegate: SearchSeriesDelegate(
                        initialSeries: searchedSeries,
                        searchSeries: ref
                            .read(searchedSeriesProvider.notifier)
                            .searchSeriesByQuery,
                      ),
                    ).then((series) {
                      if (series == null) return;
                      context.push('/series/${series.id}');
                    });
                  } else {
                    // Búsqueda de películas
                    final searchedMovies = ref.read(searchedMoviesProvider);
                    final searchQuery = ref.read(searchQueryMoviesProvider);

                    showSearch<Movie?>(
                      query: searchQuery,
                      context: context,
                      delegate: SearchMovieDelegate(
                        initialMovies: searchedMovies,
                        searchMovies: ref
                            .read(searchedMoviesProvider.notifier)
                            .searchMoviesByQuery,
                      ),
                    ).then((movie) {
                      if (movie == null) return;
                      context.push('/movie/${movie.id}');
                    });
                  }
                },
                icon: const Icon(Icons.search),
              )
            ],
          ),
        ),
      )
    );
  }
}