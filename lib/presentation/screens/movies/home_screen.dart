import 'package:cinemapedia_220031/presentation/providers/movies/initialLoading_provider.dart';
import 'package:cinemapedia_220031/presentation/providers/providers.dart';
import 'package:cinemapedia_220031/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigationbar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(mexicanMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullscreenLoader();

    final nowPlaying = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideShowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final mexicanMovies = ref.watch(mexicanMoviesProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            CustomAppbar(),
            MovieSlideshow(movies: slideShowMovies),
            MovieHorizontalListview(
              movies: nowPlaying,
              title: 'En cines',
              subTitle: 'Jueves, 3 de Noviembre',
              loadNextPage: () => 
                ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
            ),
            
            MovieHorizontalListview(
              movies: upcomingMovies,
              title: 'Próximamente',
              subTitle: 'Noviembre',
              loadNextPage: () => 
                ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
            ),
            
            MovieHorizontalListview(
              movies: popularMovies,
              title: 'Populares',
              subTitle: 'Noviembre',
              loadNextPage: () => 
                ref.read(popularMoviesProvider.notifier).loadNextPage(),
            ),
            
            MovieHorizontalListview(
              movies: topRatedMovies,
              title: 'Mejor calificadas',
              subTitle: 'Noviembre',
              loadNextPage: () => 
                ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
            ),
            
            MovieHorizontalListview(
              movies: mexicanMovies,
              title: 'Mexicanas',
              subTitle: 'Noviembre',
              loadNextPage: () => 
                ref.read(mexicanMoviesProvider.notifier).loadNextPage(),
            ),
            
            const SizedBox(height: 10)
          ]),
        ),
      ],
    );
  }
}