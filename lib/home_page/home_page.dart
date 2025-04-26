import 'package:disney/home_page/carousel/carousel.dart';
import 'package:disney/home_page/sections/list_section.dart';
import 'package:disney/home_page/sections/movies_list_view.dart';
import 'package:disney/movies/movie.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      clipBehavior: Clip.none,
      slivers: [
        SliverPadding(padding: EdgeInsets.all(16)),
        SliverToBoxAdapter(
          child: Carousel(),
        ),
        SliverList.separated(
            itemCount: categories.length,
            separatorBuilder: (context, index) => const SizedBox(
                  height: 24,
                ),
            itemBuilder: (context, index) {
              return ListSection(
                title: categories[index].title,
                child: index == 1
                    ? MoviesListView.large(category: categories[index])
                    : MoviesListView.standard(category: categories[index]),
              );
            }),
        SliverPadding(padding: EdgeInsets.all(16))
      ],
    );
  }
}

// /// An [Action] that moves the focus to the focusable node in the direction
// /// configured by the associated [DirectionalFocusIntent.direction].
// ///
// /// This is the [Action] associated with [DirectionalFocusIntent] and bound by
// /// default to the [LogicalKeyboardKey.arrowUp], [LogicalKeyboardKey.arrowDown],
// /// [LogicalKeyboardKey.arrowLeft], and [LogicalKeyboardKey.arrowRight] keys in
// /// the [WidgetsApp], with the appropriate associated directions.
// class DirectionalFocusAction2 extends Action<DirectionalFocusIntent> {
//   /// Creates a [DirectionalFocusAction].
//   DirectionalFocusAction2();

//   @override
//   void invoke(DirectionalFocusIntent intent) {
//     print(intent);
//     primaryFocus!.focusInDirection(intent.direction);
//   }
// }
