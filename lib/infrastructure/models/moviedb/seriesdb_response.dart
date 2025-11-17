import 'series_moviedb.dart';


class SeriesDbResponse {
    SeriesDbResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    final int page;
    final List<SeriesMovieDB> results;
    final int totalPages;
    final int totalResults;

    factory SeriesDbResponse.fromJson(Map<String, dynamic> json) => SeriesDbResponse(
        page: json["page"],
        results: List<SeriesMovieDB>.from(json["results"].map((x) => SeriesMovieDB.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}