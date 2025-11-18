import 'package:go_router/go_router.dart';
import 'package:cinemapedia_220031/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    
    // Splash Screen
    GoRoute(
      path: '/splash',
      name: SplashScreen.name,
      builder: (context, state) => const SplashScreen(),
    ),

    // Home Screen (Películas)
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    ),

    // Series Screen
    GoRoute(
      path: '/series',
      name: SeriesScreen.name,
      builder: (context, state) => const SeriesScreen(),
    ),

    // Movie Detail Screen (nuevo)
    GoRoute(
      path: '/movie/:id',
      name: MovieDetailScreen.name,
      builder: (context, state) {
        final movieId = state.pathParameters['id'] ?? 'no-id';
        return MovieDetailScreen(movieId: movieId);
      },
    ),

    // Series Detail Screen
    GoRoute(
      path: '/series/:id',
      name: 'series-detail',
      builder: (context, state) {
        final seriesId = state.pathParameters['id'] ?? 'no-id';
        return SeriesDetailScreen(seriesId: seriesId);
      },
    ),

  ]
);