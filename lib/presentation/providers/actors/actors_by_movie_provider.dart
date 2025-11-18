import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_220031/domain/entities/actor.dart';
import 'package:cinemapedia_220031/presentation/providers/actors/actors_repository_provider.dart';

final actorsByMovieProvider = NotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>(
  ActorsByMovieNotifier.new
);

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends Notifier<Map<String, List<Actor>>> {
  late final GetActorsCallback getActors;

  @override
  Map<String, List<Actor>> build() {
    final actorsRepository = ref.watch(actorsRepositoryProvider);
    getActors = actorsRepository.getActorsByMovie;
    return {};
  }

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;

    final List<Actor> actors = await getActors(movieId);
    state = {...state, movieId: actors};
  }
}