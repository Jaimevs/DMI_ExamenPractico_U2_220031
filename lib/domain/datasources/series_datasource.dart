import 'package:cinemapedia_220031/domain/entities/series.dart';


abstract class SeriesDatasource {

  Future<List<Series>> getAiringToday({ int page = 1 });
  Future<List<Series>> getPopular({ int page = 1 });
  Future<List<Series>> getTopRated({ int page = 1 });
  Future<List<Series>> getUpcoming({ int page = 1 });

}