import 'package:cinemapedia_220031/domain/entities/series.dart';
import 'package:cinemapedia_220031/infrastructure/models/moviedb/series_moviedb.dart';
import 'package:cinemapedia_220031/infrastructure/models/moviedb/series_details.dart';

class SeriesMapper {

  static Series seriesDBToEntity(SeriesMovieDB seriesdb) => Series(
    adult: seriesdb.adult,
    backdropPath: seriesdb.backdropPath.isNotEmpty
      ? 'https://image.tmdb.org/t/p/w500${seriesdb.backdropPath}'
      : '',
    genreIds: seriesdb.genreIds.map((e) => e.toString()).toList(),
    id: seriesdb.id,
    originalLanguage: seriesdb.originalLanguage,
    originalTitle: seriesdb.originalTitle,
    overview: seriesdb.overview,
    popularity: seriesdb.popularity ?? 0.0,
    posterPath: seriesdb.posterPath.isNotEmpty
      ? 'https://image.tmdb.org/t/p/w500${seriesdb.posterPath}'
      : '',
    firstAirDate: seriesdb.firstAirDate,
    name: seriesdb.name,
    voteAverage: seriesdb.voteAverage ?? 0.0,
    voteCount: seriesdb.voteCount
  );

  static Series seriesDetailsToEntity(SeriesDetails seriesDb) => Series(
    adult: seriesDb.adult,
    backdropPath: seriesDb.backdropPath.isNotEmpty
      ? 'https://image.tmdb.org/t/p/w500${seriesDb.backdropPath}'
      : '',
    genreIds: seriesDb.genres.map((e) => e.name).toList(),
    id: seriesDb.id,
    originalLanguage: seriesDb.originalLanguage,
    originalTitle: seriesDb.originalName,
    overview: seriesDb.overview,
    popularity: seriesDb.popularity,
    posterPath: seriesDb.posterPath.isNotEmpty
      ? 'https://image.tmdb.org/t/p/w500${seriesDb.posterPath}'
      : '',
    firstAirDate: seriesDb.firstAirDate,
    name: seriesDb.name,
    voteAverage: seriesDb.voteAverage,
    voteCount: seriesDb.voteCount
  );
}