
class Movie {

  // indica si las peliculas son para adultos
  final bool adult;
  // ruta del fondo de fondo
  final String backdropPath;
  //lista de IDs de generos
  final List<String> genreIds;
  // id univo de las pelicula en TMDB
  final int id;
  // idioma original de la pelicula
  final String originalLanguage;
  // titulo original de la pelicula
  final String originalTitle;
  // descripcion de la pelicula
  final String overview;
  // popularidad de la pelicula
  final double popularity;
  // ruta del poster de la pelicula
  final String posterPath;
  // fecha de lanzamiento de la pelicula
  final DateTime releaseDate;
  // titulo de la pelicula
  final String title;
  // indica si la pelicula tiene video
  final bool video;
  // promedio de votos de la pelicula
  final double voteAverage;
  // numero de votos de la pelicula
  final int voteCount;

  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount
  });
}