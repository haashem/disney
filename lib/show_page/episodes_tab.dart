import 'package:disney/home_page/movie_tile.dart';
import 'package:disney/movies/movie.dart';
import 'package:flutter/material.dart';

class EpisodesTab extends StatefulWidget {
  const EpisodesTab({super.key});

  @override
  State<EpisodesTab> createState() => _EpisodesTabState();
}

class _EpisodesTabState extends State<EpisodesTab> {
  int selectedSeasonIndex = 0;
  final List<FocusNode> seasonFocusNodes = List.generate(
    3,
    (index) => FocusNode(debugLabel: 'Season $index'),
  );
  @override
  void dispose() {
    for (var node in seasonFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          Focus(
            skipTraversal: true,
            onFocusChange: (isFocused) {
              if (isFocused) {
                seasonFocusNodes[selectedSeasonIndex].requestFocus();
              }
            },
            child: SizedBox(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 32,
                children: [
                  _SeasonButton(
                    title: 'Season 1',
                    isSelected: selectedSeasonIndex == 0,
                    focusNode: seasonFocusNodes[0],
                    onPressed: () {
                      setState(() {
                        selectedSeasonIndex = 0;
                      });
                    },
                  ),
                  _SeasonButton(
                    title: 'Season 2',
                    isSelected: selectedSeasonIndex == 1,
                    focusNode: seasonFocusNodes[1],
                    onPressed: () {
                      setState(() {
                        selectedSeasonIndex = 1;
                      });
                    },
                  ),
                  _SeasonButton(
                    title: 'Season 3',
                    isSelected: selectedSeasonIndex == 2,
                    focusNode: seasonFocusNodes[2],
                    onPressed: () {
                      setState(() {
                        selectedSeasonIndex = 2;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
                itemCount: seasons[selectedSeasonIndex].length,
                separatorBuilder: (context, index) => const SizedBox(
                      height: 16,
                    ),
                itemBuilder: (context, index) =>
                    _EpisodeTile(episode: seasons[selectedSeasonIndex][index])),
          ),
        ],
      ),
    );
  }
}

class _SeasonButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isSelected;
  final FocusNode focusNode;
  const _SeasonButton(
      {required this.onPressed,
      required this.isSelected,
      required this.focusNode,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      focusNode: focusNode,
      style: ButtonStyle(
        padding: WidgetStateProperty.resolveWith((states) {
          return EdgeInsets.symmetric(horizontal: 12);
        }),
        minimumSize: WidgetStatePropertyAll(
          Size.zero,
        ),
        backgroundBuilder: (context, states, child) {
          return Container(
            height: 30,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: states.contains(WidgetState.focused)
                      ? Colors.white
                      : Colors.transparent,
                  width: 3,
                ),
              ),
            ),
            child: child,
          );
        },
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(),
        ),
        overlayColor: WidgetStatePropertyAll(
          Colors.transparent,
        ),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (isSelected || states.contains(WidgetState.focused)) {
            return Colors.white;
          }
          return Colors.white54;
        }),
        textStyle: WidgetStatePropertyAll(
          const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w300, letterSpacing: 1),
        ),
      ),
      child: Text(title),
    );
  }
}

class _EpisodeTile extends StatelessWidget {
  final Movie episode;
  const _EpisodeTile({required this.episode});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MovieTile(movie: episode, focusNode: FocusNode(), onPressed: () {}),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                episode.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                episode.description,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
