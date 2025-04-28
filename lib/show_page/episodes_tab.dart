import 'package:disney/home_page/movie_tile.dart';
import 'package:disney/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final FocusScopeNode _seasonsFocusNode =
      FocusScopeNode(debugLabel: 'Seasons Focus Node', skipTraversal: true);
  final FocusScopeNode _episodesFocusNode =
      FocusScopeNode(debugLabel: 'Episodes Focus Node', skipTraversal: true);

  @override
  void dispose() {
    for (var node in seasonFocusNodes) {
      node.dispose();
    }
    _seasonsFocusNode.dispose();
    _episodesFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          FocusScope(
            skipTraversal: true,
            node: _seasonsFocusNode,
            onFocusChange: (isFocused) {
              if (isFocused) {
                seasonFocusNodes[selectedSeasonIndex].requestFocus();
              }
            },
            onKeyEvent: (node, event) {
              if (event is KeyUpEvent) {
                return KeyEventResult.handled;
              }
              if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                if (_seasonsFocusNode.focusInDirection(TraversalDirection.up)) {
                  return KeyEventResult.handled;
                }
                return KeyEventResult.ignored;
              }
              if (event.logicalKey != LogicalKeyboardKey.arrowRight) {
                return KeyEventResult.ignored;
              }
              _episodesFocusNode.requestFocus();
              _episodesFocusNode.focusInDirection(TraversalDirection.right);
              return KeyEventResult.handled;
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
                        _focusOnTheFirstEpisode();
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
                        _focusOnTheFirstEpisode();
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
                        _focusOnTheFirstEpisode();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FocusScope(
              node: _episodesFocusNode,
              onKeyEvent: (node, event) {
                if (event is KeyUpEvent) {
                  return KeyEventResult.handled;
                }
                if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                  if (_episodesFocusNode
                      .focusInDirection(TraversalDirection.up)) {
                    return KeyEventResult.handled;
                  }
                  return KeyEventResult.ignored;
                }
                if (event.logicalKey != LogicalKeyboardKey.arrowLeft) {
                  return KeyEventResult.ignored;
                }
                _seasonsFocusNode.requestFocus();
                return KeyEventResult.handled;
              },
              child: ListView.separated(
                  itemCount: seasons[selectedSeasonIndex].length,
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 16,
                      ),
                  itemBuilder: (context, index) => _EpisodeTile(
                      episode: seasons[selectedSeasonIndex][index])),
            ),
          ),
        ],
      ),
    );
  }

  void _focusOnTheFirstEpisode() {
    _episodesFocusNode.requestFocus(_episodesFocusNode.children.first);
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
        textStyle: WidgetStateProperty.resolveWith((states) {
          if (isSelected || states.contains(WidgetState.focused)) {
            return Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                );
          }
          return Theme.of(context).textTheme.bodyLarge;
        }),
      ),
      child: Text(title),
    );
  }
}

class _EpisodeTile extends StatefulWidget {
  final Movie episode;
  const _EpisodeTile({required this.episode});

  @override
  State<_EpisodeTile> createState() => _EpisodeTileState();
}

class _EpisodeTileState extends State<_EpisodeTile> {
  late final FocusNode focusNode = FocusNode(debugLabel: widget.episode.title);

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MovieTile(
            movie: widget.episode, focusNode: focusNode, onPressed: () {}),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.episode.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.episode.description,
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
