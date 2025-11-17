class Series {

  // indica si la serie es para adultos
  final bool adult;
  // ruta del fondo de la serie
  final String backdropPath;
  // lista de IDs de géneros
  final List<String> genreIds;
  // id único de la serie en TMDB
  final int id;
  // idioma original de la serie
  final String originalLanguage;
  // título original de la serie
  final String originalTitle;
  // descripción de la serie
  final String overview;
  // popularidad de la serie
  final double popularity;
  // ruta del poster de la serie
  final String posterPath;
  // fecha del primer episodio
  final DateTime firstAirDate;
  // título de la serie
  final String name;
  // promedio de votos de la serie
  final double voteAverage;
  // número de votos de la serie
  final int voteCount;

  Series({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount
  });
}