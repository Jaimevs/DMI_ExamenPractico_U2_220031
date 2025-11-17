import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia_220031/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class MovieHorizontalListviewUpcoming extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListviewUpcoming({
    super.key,
    required this.movies,
    this.title,
    this.subTitle,
    this.loadNextPage,
  });

  @override
  State<MovieHorizontalListviewUpcoming> createState() =>
      _MovieHorizontalListviewUpcomingState();
}

class _MovieHorizontalListviewUpcomingState extends State<MovieHorizontalListviewUpcoming> {
    final scrollController = ScrollController();
    @override
    void initState() {
      super.initState();
      
      scrollController.addListener(() {
        if (widget.loadNextPage == null) return;
        if (scrollController.position.pixels + 200 >=
            scrollController.position.maxScrollExtent) {
          print('Cargando las peliculas siguientes');
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
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return _Slide(movie: widget.movies[index]);
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
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    
    // Formatear fecha de estreno
    final dateFormat = DateFormat('d \'de\' MMM', 'es_MX');
    final formattedDate = dateFormat.format(movie.releaseDate);

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
                movie.posterPath,
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
                    onTap: () => context.push('/movie/${movie.id}'),
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
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textStyles.titleSmall,
            ),
          ),

          const SizedBox(height: 3),

          // Release Date
          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: Colors.blue.shade400,
                  size: 16,
                ),
                const SizedBox(width: 5),
                Text(
                  formattedDate,
                  style: textStyles.bodyMedium?.copyWith(
                    color: Colors.blue.shade400,
                    fontWeight: FontWeight.w600,
                  ),
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
          if (place != null) 
            Expanded(
              child: Text(place!, style: placeStyle),
            ),
          if (formatedDate != null)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: FilledButton.tonal(
                onPressed: () {}, 
                child: Text(
                  formatedDate!,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
        ],
      ),
    );
  }
}