import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:cinemapedia_220031/domain/entities/series.dart';
import 'package:cinemapedia_220031/presentation/providers/providers.dart';
import 'package:cinemapedia_220031/config/helpers/human_formats.dart';

class SeriesDetailScreen extends ConsumerStatefulWidget {
  static const name = 'series-detail';
  final String seriesId;

  const SeriesDetailScreen({
    super.key,
    required this.seriesId
  });

  @override
  SeriesDetailScreenState createState() => SeriesDetailScreenState();
}

class SeriesDetailScreenState extends ConsumerState<SeriesDetailScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(seriesInfoProvider.notifier).loadSeries(widget.seriesId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.seriesId);
  }

  @override
  Widget build(BuildContext context) {
    final Series? series = ref.watch(seriesInfoProvider)[widget.seriesId];

    if (series == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(series: series),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _SeriesDetails(series: series, seriesId: widget.seriesId),
              childCount: 1
            ),
          )
        ],
      ),
    );
  }
}

class _SeriesDetails extends ConsumerWidget {
  final Series series;
  final String seriesId;

  const _SeriesDetails({
    required this.series,
    required this.seriesId
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Información principal
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Poster
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  series.posterPath,
                  width: size.width * 0.35,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      );
                    }
                    return child;
                  },
                ),
              ),

              const SizedBox(width: 16),

              // Información
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      series.name,
                      style: textStyles.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    // Rating
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow.shade700,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${series.voteAverage.toStringAsFixed(1)}/10',
                          style: textStyles.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '${series.voteCount} votos',
                          style: textStyles.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Popularidad
                    Row(
                      children: [
                        const Icon(Icons.trending_up, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          'Popular: ${HumanFormats.number(series.popularity)}',
                          style: textStyles.bodySmall,
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Fecha de lanzamiento
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          series.firstAirDate.year.toString(),
                          style: textStyles.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Géneros
        if (series.genreIds.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              children: series.genreIds.map((genre) {
                return Chip(
                  label: Text(genre),
                  labelStyle: const TextStyle(fontSize: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                );
              }).toList(),
            ),
          ),

        const SizedBox(height: 16),

        // Sinopsis
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sinopsis',
                style: textStyles.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                series.overview,
                style: textStyles.bodyMedium,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Elenco
        _ActorsBySeries(seriesId: seriesId),

        const SizedBox(height: 50),
      ],
    );
  }
}

class _ActorsBySeries extends ConsumerWidget {
  final String seriesId;

  const _ActorsBySeries({required this.seriesId});

  @override
  Widget build(BuildContext context, ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);
    final textStyles = Theme.of(context).textTheme;

    if (actorsByMovie[seriesId] == null) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    final actors = actorsByMovie[seriesId]!;

    if (actors.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Elenco',
            style: textStyles.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: actors.length,
            itemBuilder: (context, index) {
              final actor = actors[index];

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 130,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Foto del actor
                    FadeInRight(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          actor.profilePath,
                          height: 160,
                          width: 130,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 160,
                              width: 130,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Nombre del actor
                    Text(
                      actor.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textStyles.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Personaje
                    Text(
                      actor.character ?? 'Sin personaje',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textStyles.bodySmall?.copyWith(
                        color: Colors.grey[600],
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Series series;

  const _CustomSliverAppBar({
    required this.series
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.55,
      foregroundColor: Colors.white,
      pinned: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => context.pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            // Imagen de fondo
            SizedBox.expand(
              child: Image.network(
                series.backdropPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return Container(
                      color: Colors.grey[800],
                    );
                  }
                  return child;
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[800],
                    child: const Center(
                      child: Icon(
                        Icons.tv,
                        size: 80,
                        color: Colors.white24,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Gradientes
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.5, 1.0],
                    colors: [
                      Colors.black54,
                      Colors.black45,
                      Colors.black87,
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    stops: [0.0, 0.3],
                    colors: [
                      Colors.black54,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}