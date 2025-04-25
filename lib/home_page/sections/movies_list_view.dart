import 'package:disney/home_page/movie_tile.dart';
import 'package:disney/movies/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum _DisplaySize {
  standard,
  large,
}

class MoviesListView extends StatelessWidget {
  final CategorizedMovie category;
  final _DisplaySize _displaySize;

  late final List<FocusNode> movieFocusNodes = List.generate(
    movies.length,
    (index) => FocusNode(debugLabel: 'MovieTile $index'),
  );

  MoviesListView.standard({
    super.key,
    required this.category,
  }) : _displaySize = _DisplaySize.standard;

  MoviesListView.large({
    super.key,
    required this.category,
  }) : _displaySize = _DisplaySize.large;

  late final List<Movie> movies = category.movies;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: switch (_displaySize) {
        _DisplaySize.standard => 132,
        _DisplaySize.large => 400,
      },
      child: ListView.separated(
        padding: const EdgeInsets.only(right: 32),
        itemCount: movies.length,
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemBuilder: (context, index) => MovieTile(
          movie: movies[index],
          focusNode: movieFocusNodes[index],
          onPressed: () => context.go('/showpage?movie=${movies[index].title}'),
        ),
        separatorBuilder: (context, index) => SizedBox(
          width: 16,
        ),
      ),
    );
  }
}
