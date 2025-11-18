import 'package:cinemapedia_220031/domain/entities/movie.dart';
import 'package:cinemapedia_220031/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia_220031/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {

  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
    adult: moviedb.adult,
    backdropPath: (moviedb.backdropPath != '') 
      ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
      : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
    genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
    id: moviedb.id,
    originalLanguage: moviedb.originalLanguage,
    originalTitle: moviedb.originalTitle,
    overview: moviedb.overview,
    popularity: moviedb.popularity ?? 0.0,
    posterPath: (moviedb.posterPath != '')
      ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
      : 'no-poster',
    releaseDate: moviedb.releaseDate,
    title: moviedb.title,
    video: moviedb.video,
    voteAverage: moviedb.voteAverage ?? 0.0,
    voteCount: moviedb.voteCount
  );

  static Movie movieDetailsToEntity(MovieDetails movieDb) => Movie(
    adult: movieDb.adult,
    backdropPath: (movieDb.backdropPath != '')
      ? 'https://image.tmdb.org/t/p/w500${movieDb.backdropPath}'
      : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
    genreIds: movieDb.genres.map((e) => e.name).toList(),
    id: movieDb.id,
    originalLanguage: movieDb.originalLanguage,
    originalTitle: movieDb.originalTitle,
    overview: movieDb.overview,
    popularity: movieDb.popularity,
    posterPath: (movieDb.posterPath != '')
      ? 'https://image.tmdb.org/t/p/w500${movieDb.posterPath}'
      : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
    releaseDate: movieDb.releaseDate,
    title: movieDb.title,
    video: movieDb.video,
    voteAverage: movieDb.voteAverage,
    voteCount: movieDb.voteCount
  );
}