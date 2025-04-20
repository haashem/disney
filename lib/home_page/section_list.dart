import 'package:disney/home_page/movie_tile.dart';
import 'package:disney/movies/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SectionList extends StatelessWidget {
  final String title;
  final List<Movie> movies;

  const SectionList({
    super.key,
    required this.title,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SizedBox(
          height: 132,
          child: ListView.separated(
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemBuilder: (context, index) => MovieTile(
              movie: movies[0],
              onPressed: () => context.go('/showpage'),
            ),
            separatorBuilder: (context, index) => SizedBox(
              width: 16,
            ),
          ),
        ),
      ],
    );
  }
}
