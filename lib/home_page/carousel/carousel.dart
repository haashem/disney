import 'package:disney/home_page/carousel/page_indicator.dart';
import 'package:disney/movies/movie.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  final List<Movie> movies;

  const Carousel({
    super.key,
    required this.movies,
  });

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel>
    with SingleTickerProviderStateMixin {
  late final List<Movie> movies = widget.movies;
  late final TabController _tabController = TabController(
    length: movies.length,
    vsync: this,
  );
  late final PageController _pageController = PageController(
    viewportFraction: 0.85,
  );
  bool isFocused = false;
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
                clipBehavior: Clip.none,
                itemCount: _tabController.length,
                controller: _pageController,
                onPageChanged: handlePageChange,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ElevatedButton(
                      clipBehavior: Clip.hardEdge,
                      onHover: (value) => setState(() {
                        isHovered = value;
                      }),
                      onFocusChange: (value) => setState(() {
                        isFocused = value;
                      }),
                      onPressed: () {},
                      style: ButtonStyle(
                        padding: WidgetStatePropertyAll(
                          const EdgeInsets.all(0),
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        side: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.focused)) {
                            return const BorderSide(
                              color: Colors.white,
                              width: 2,
                            );
                          }
                          return null;
                        }),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            movies[index].coverImageUrl,
                            fit: BoxFit.fitWidth,
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 16,
          ),
          PageIndicator(
            tabController: _tabController,
          ),
        ],
      ),
    );
  }

  void handlePageChange(int page) {
    _tabController.animateTo(page);
  }
}
