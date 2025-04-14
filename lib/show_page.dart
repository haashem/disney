import 'package:disney/movies/movie.dart';
import 'package:flutter/material.dart';

class ShowPage extends StatelessWidget {
  final Movie movie;

  const ShowPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ShaderMask(
                  blendMode: BlendMode.dstIn,
                  shaderCallback: (rect) => LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black,
                      Colors.black,
                      Colors.black.withValues(alpha: 0.30),
                      Colors.black.withValues(alpha: 0.0),
                    ],
                  ).createShader(rect),
                  child: ShaderMask(
                    shaderCallback: (rect) => RadialGradient(
                        center: Alignment(0.5, -1),
                        radius: 1.5,
                        colors: [
                          Colors.black,
                          Colors.black,
                          Colors.black.withValues(alpha: 0.30),
                          Colors.black.withValues(alpha: 0.0),
                        ]).createShader(rect),
                    blendMode: BlendMode.dstIn,
                    child: Image.asset(
                      movie.coverImageUrl,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
