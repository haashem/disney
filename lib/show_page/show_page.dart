import 'package:disney/models/movie.dart';
import 'package:disney/show_page/extra_pane.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ShowPage extends StatefulWidget {
  final Movie movie;

  const ShowPage({super.key, required this.movie});

  @override
  State<ShowPage> createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {
  bool backdropIsVisible = true;
  FocusScopeNode backdropNode = FocusScopeNode(debugLabel: 'Movie Details');
  late FocusNode extraPaneNode = FocusNode(
    debugLabel: 'Extra Pane',
    skipTraversal: true,
    onKeyEvent: (node, event) {
      if (event is KeyUpEvent) {
        return KeyEventResult.handled;
      }
      if (event.logicalKey != LogicalKeyboardKey.arrowUp) {
        return KeyEventResult.ignored;
      }

      if (!extraPaneNode.focusInDirection(TraversalDirection.up)) {
        backdropNode.requestFocus();
      }
      return KeyEventResult.handled;
    },
  );

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    final Size stackSize = constraints.biggest;

    return Stack(
      fit: StackFit.expand,
      children: [
        _BackgroundCover(
          coverImagePath: widget.movie.coverImageUrl,
        ),
        FocusScope(
          node: backdropNode,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 112),
                  Image.asset(
                    widget.movie.titleImageUrl,
                    scale: 2.5,
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.movie.yearAndCategory,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: 400,
                    child: Text(
                      widget.movie.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(height: 32),
                  Row(
                    children: [
                      FilledButton(
                        autofocus: true,
                        onPressed: () => context.go(
                            '/showpage/playback?movie=${widget.movie.title}'),
                        child: const Text('Play'),
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          onKeyEvent: (node, event) {
            if (event is KeyUpEvent) {
              return KeyEventResult.handled;
            }
            if (event.logicalKey != LogicalKeyboardKey.arrowDown) {
              return KeyEventResult.ignored;
            }

            if (!backdropNode.focusInDirection(TraversalDirection.down)) {
              extraPaneNode.requestFocus(extraPaneNode.descendants.first);
            }
            return KeyEventResult.handled;
          },
        ),
        AnimatedPositioned(
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 300),
            top: backdropIsVisible ? stackSize.height * 0.85 : 0.0,
            width: stackSize.width,
            height: stackSize.height,
            child: ExtraPane(
                onFocusChange: (paneFocused) {
                  setState(() {
                    backdropIsVisible = !paneFocused;
                    if (backdropIsVisible) {
                      backdropNode.requestFocus();
                    }
                  });
                },
                focusNode: extraPaneNode,
                movie: widget.movie)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Show Page'),
        //   // leading: IconButton(
        //   //   icon: const Icon(Icons.arrow_back),
        //   //   onPressed: () => Navigator.of(context).pop(),
        //   // ),

        // ),
        body: FocusableActionDetector(
      focusNode: FocusNode(skipTraversal: true),
      shortcuts: {
        SingleActivator(LogicalKeyboardKey.escape): const DismissIntent(),
      },
      actions: {
        DismissIntent: CallbackAction<DismissIntent>(
          onInvoke: (intent) => Navigator.of(context).pop(),
        ),
      },
      child: LayoutBuilder(
        builder: _buildStack,
      ),
    ));
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
