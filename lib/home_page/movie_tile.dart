import 'package:disney/movies/movie.dart';
import 'package:flutter/material.dart';

class MovieTile extends StatefulWidget {
  final VoidCallback onPressed;
  final Movie movie;
  final FocusNode? focusNode;

  const MovieTile({
    super.key,
    required this.movie,
    required this.focusNode,
    required this.onPressed,
  });

  @override
  State<MovieTile> createState() => _MovieTileState();
}

class _MovieTileState extends State<MovieTile> {
  bool isFocused = false;
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isFocused || isHovered ? 1.05 : 1,
      duration: Duration(milliseconds: 300),
      child: ElevatedButton(
        clipBehavior: Clip.hardEdge,
        focusNode: widget.focusNode,
        onHover: (value) => setState(() {
          isHovered = value;
        }),
        onFocusChange: (value) => setState(() {
          isFocused = value;
        }),
        onPressed: widget.onPressed,
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(
            const EdgeInsets.all(0),
          ),
          fixedSize: WidgetStatePropertyAll(
            const Size(230, 130),
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
        child: Container(
          constraints: BoxConstraints.expand(),
          child: Image.asset(
            widget.movie.tileImageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
