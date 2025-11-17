import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia_220031/config/helpers/human_formats.dart';
import 'package:cinemapedia_220031/domain/entities/series.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SeriesHorizontalListview extends StatefulWidget {
  final List<Series> series;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const SeriesHorizontalListview({
    super.key,
    required this.series,
    this.title,
    this.subTitle,
    this.loadNextPage,
  });

  @override
  State<SeriesHorizontalListview> createState() =>
      _SeriesHorizontalListviewState();
}

class _SeriesHorizontalListviewState extends State<SeriesHorizontalListview> {
    final scrollController = ScrollController();
    @override
    void initState() {
      super.initState();
      
      scrollController.addListener(() {
        if (widget.loadNextPage == null) return;
        if (scrollController.position.pixels + 200 >=
            scrollController.position.maxScrollExtent) {
          print('Cargando las series siguientes');
          widget.loadNextPage!();
        }
      });
    }

    @override
    void dispose() {
      scrollController.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: Column(
        children: [
          if (widget.title != null || widget.subTitle != null)
            _CurrDate(place: widget.title, formatedDate: widget.subTitle),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.series.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return _Slide(serie: widget.series[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- SLIDE ----------------

class _Slide extends StatelessWidget {
  final Series serie;
  const _Slide({required this.serie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Poster
          SizedBox(
            width: 150,
            height: 215,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                serie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  }
                  return GestureDetector(
                    onTap: () => context.push('/series/${serie.id}'),
                    child: FadeIn(child: child),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 5),

          // Title
          SizedBox(
            width: 150,
            child: Text(
              serie.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textStyles.titleSmall,
            ),
          ),

          const SizedBox(height: 3),

          // Rating
          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(
                  Icons.star_half_outlined,
                  color: Colors.yellow.shade800,
                  size: 16,
                ),
                const SizedBox(width: 3),
                Text(
                  '${serie.voteAverage}',
                  style: textStyles.bodyMedium?.copyWith(
                    color: Colors.yellow.shade800,
                  ),
                ),
                const Spacer(),
                Text(
                  HumanFormats.humanReadbleNumber(serie.popularity),
                  style: textStyles.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- HEADER ----------------

class _CurrDate extends StatelessWidget {
  final String? place;
  final String? formatedDate;

  const _CurrDate({this.place, this.formatedDate});

  @override
  Widget build(BuildContext context) {
    final placeStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (place != null) Text(place!, style: placeStyle),
          const Spacer(),
          if (formatedDate != null)
            FilledButton.tonal(onPressed: () {}, child: Text(formatedDate!)),
        ],
      ),
    );
  }
}