import 'package:disney/home_page/section_list.dart';
import 'package:disney/movies/movie.dart';
import 'package:disney/side_menu/side_menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        // fit: StackFit.expand,
        children: [
          Row(
            children: [
              SizedBox(
                width: 74,
              ),
              Expanded(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverList.separated(
                        itemCount: 2,
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 24,
                            ),
                        itemBuilder: (context, index) {
                          return SectionList(
                            title: categories.first.title,
                            movies: categories.first.movies,
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
          SideMenu(),
        ],
      ),
    );
  }
}
