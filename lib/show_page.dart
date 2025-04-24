import 'package:disney/movies/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ShowPage extends StatelessWidget {
  final Movie movie;

  const ShowPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FocusableActionDetector(
        autofocus: false,
        focusNode: FocusNode(skipTraversal: true),
        shortcuts: {
          SingleActivator(LogicalKeyboardKey.escape): const DismissIntent(),
        },
        actions: {
          DismissIntent: CallbackAction<DismissIntent>(
            onInvoke: (intent) => Navigator.of(context).pop(),
          ),
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            _BackgroundCover(
              coverImagePath: movie.coverImageUrl,
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 64),
                    Image.asset(
                      movie.titleImageUrl,
                      scale: 3,
                    ),
                    SizedBox(height: 8),
                    Text(
                      movie.yearAndCategory,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      width: 400,
                      child: Text(
                        movie.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        FilledButton(
                          autofocus: true,
                          onPressed: () => context.go('/showpage/playback?movie=${movie.title}'),
                          child: const Text('Play'),
                        ),
                        const SizedBox(width: 16),
                        IconButton.outlined(
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _BackgroundCover extends StatelessWidget {
  final String coverImagePath;
  const _BackgroundCover({required this.coverImagePath});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
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
                coverImagePath,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
