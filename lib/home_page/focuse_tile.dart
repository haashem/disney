import 'package:flutter/material.dart';

class IntereactiveTile extends StatefulWidget {
  final VoidCallback onPressed;
  final String imageUrl;
  final FocusNode? focusNode;

  const IntereactiveTile({
    super.key,

    this.focusNode,
    required this.imageUrl,
    required this.onPressed,
  });

  @override
  State<IntereactiveTile> createState() => _IntereactiveTileState();
}

class _IntereactiveTileState extends State<IntereactiveTile> {
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
            widget.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
