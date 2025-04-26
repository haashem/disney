import 'package:disney/home_page/movie_tile.dart';
import 'package:disney/movies/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum _DisplaySize {
  standard,
  large,
}

class MoviesListView extends StatefulWidget {
  final CategorizedMovie category;
  final _DisplaySize _displaySize;

  const MoviesListView.standard({
    super.key,
    required this.category,
  }) : _displaySize = _DisplaySize.standard;

  const MoviesListView.large({
    super.key,
    required this.category,
  }) : _displaySize = _DisplaySize.large;

  @override
  State<MoviesListView> createState() => _MoviesListViewState();
}

class _MoviesListViewState extends State<MoviesListView> {
  late final List<FocusNode> movieFocusNodes = List.generate(
    movies.length,
    (index) => FocusNode(debugLabel: movies[index].title),
  );

  late final List<Movie> movies = widget.category.movies;

  @override
  void dispose() {
    for (var node in movieFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: switch (widget._displaySize) {
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
