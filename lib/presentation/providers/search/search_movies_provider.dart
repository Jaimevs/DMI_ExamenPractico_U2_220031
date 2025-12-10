import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_220031/domain/entities/movie.dart';
import 'package:cinemapedia_220031/presentation/providers/movies/movies_repository_provider.dart';

// 🔹 Provider del query actual de búsqueda de películas
final searchQueryMoviesProvider = NotifierProvider<SearchQueryMoviesNotifier, String>(
  SearchQueryMoviesNotifier.new,
);

class SearchQueryMoviesNotifier extends Notifier<String> {
  @override
  String build() => '';

  void update(String newQuery) {
    state = newQuery;
  }
}

// 🔹 Provider principal de películas buscadas
final searchedMoviesProvider = NotifierProvider<SearchedMoviesNotifier, List<Movie>>(
  SearchedMoviesNotifier.new,
);

// 🔹 Definición del tipo callback
typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

// 🔹 Notifier para búsqueda de películas (Riverpod 3.x)
class SearchedMoviesNotifier extends Notifier<List<Movie>> {
  late final SearchMoviesCallback searchMovies;

  @override
  List<Movie> build() {
    final moviesRepository = ref.watch(movieRepositoryProvider);
    searchMovies = moviesRepository.searchMovies;
    return [];
  }

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final List<Movie> movies = await searchMovies(query);
    ref.read(searchQueryMoviesProvider.notifier).update(query);
    state = movies;
    return movies;
  }
}