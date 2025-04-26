import 'package:disney/playback/ui/scrub_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class PlaybackPage extends StatefulWidget {
  const PlaybackPage({super.key});

  @override
  State<PlaybackPage> createState() => _PlaybackPageState();
}

class _PlaybackPageState extends State<PlaybackPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
        _controller.play();
      });

    _controller.addListener(() {
      if (_controller.value.hasError) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Error'),
                content: Text(_controller.value.errorDescription ?? ''),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      // appBar:
      // AppBar(
      //   title: const Text('Playback'),
      //   backgroundColor: Colors.transparent,
      //   elevation: 10,
      //   shadowColor: Colors.black,
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.more_vert),
      //       onPressed: () {},
      //     ),
      //   ],
      // ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : CircularProgressIndicator(),
          ),
          VideoPlayerControls(controller: _controller),
        ],
      ),
    );
  }
}

class VideoPlayerControls extends StatefulWidget {
  final VideoPlayerController controller;

  const VideoPlayerControls({super.key, required this.controller});

  @override
  State<VideoPlayerControls> createState() => _VideoPlayerControlsState();
}

class _VideoPlayerControlsState extends State<VideoPlayerControls> {
  final Duration seekDuration = const Duration(seconds: 5);
  late final controller = widget.controller;

  _VideoPlayerControlsState() {
    listener = () {
      if (!mounted) {
        return;
      }
      setState(() {});
    };
  }

  late VoidCallback listener;
  @override
  void initState() {
    super.initState();
    controller.addListener(listener);
  }

  @override
  void deactivate() {
    controller.removeListener(listener);
    super.deactivate();
  }

  void changeVolume(double volume) {
    widget.controller.setVolume(volume);
  }

  void forward() {
    widget.controller.seekTo(widget.controller.value.position + seekDuration);
  }

  void rewind() {
    widget.controller.seekTo(widget.controller.value.position - seekDuration);
  }

  void togglePlayback() {
    if (controller.value.isPlaying) {
      pause();
    } else {
      play();
    }
  }

  void pause() {
    widget.controller.pause();
  }

  void play() {
    widget.controller.play();
  }

  String get remainingTime {
    final duration = widget.controller.value.duration;
    final position = widget.controller.value.position;
    final remaining = duration - position;
    return remaining.toString().split('.').first;
  }

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      autofocus: true,
      shortcuts: {
        SingleActivator(LogicalKeyboardKey.escape): const DismissIntent(),
        SingleActivator(LogicalKeyboardKey.arrowLeft): const RewindIntent(),
        SingleActivator(LogicalKeyboardKey.arrowRight): const ForwardIntent(),
        SingleActivator(LogicalKeyboardKey.space): const PlayPauseIntent(),
        SingleActivator(LogicalKeyboardKey.arrowUp):
            const IncreaseVolumeIntent(),
        SingleActivator(LogicalKeyboardKey.arrowDown):
            const DecreaseVolumeIntent(),
      },
      actions: {
        DismissIntent: CallbackAction<DismissIntent>(
          onInvoke: (intent) => Navigator.of(context).pop(),
        ),
        RewindIntent: CallbackAction<RewindIntent>(
          onInvoke: (intent) => rewind(),
        ),
        ForwardIntent: CallbackAction<ForwardIntent>(
          onInvoke: (intent) => forward(),
        ),
        PlayPauseIntent: CallbackAction<PlayPauseIntent>(
          onInvoke: (intent) => togglePlayback(),
        ),
        IncreaseVolumeIntent: CallbackAction<IncreaseVolumeIntent>(
          onInvoke: (intent) => changeVolume(
            (controller.value.volume + 0.1).clamp(0.0, 1.0),
          ),
        ),
        DecreaseVolumeIntent: CallbackAction<DecreaseVolumeIntent>(
          onInvoke: (intent) => changeVolume(
            (controller.value.volume - 0.1).clamp(0.0, 1.0),
          ),
        ),
      },
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ScrubBar(
              controller: widget.controller,
            ),
            IconButton(
              icon: Icon(
                  size: 40,
                  controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: () {
                if (controller.value.isPlaying) {
                  controller.pause();
                } else {
                  controller.play();
                }
              },
            ),
            SizedBox(
              height: 16,
            ),
            // IconButton(
            //   icon: const Icon(Icons.stop),
            //   onPressed: () {
            //     controller.seekTo(Duration.zero);
            //     controller.pause();
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

class RewindIntent extends Intent {
  const RewindIntent();
}

class ForwardIntent extends Intent {
  const ForwardIntent();
}

class PlayPauseIntent extends Intent {
  const PlayPauseIntent();
}

class IncreaseVolumeIntent extends Intent {
  const IncreaseVolumeIntent();
}

class DecreaseVolumeIntent extends Intent {
  const DecreaseVolumeIntent();
}

class DismissIntent extends Intent {
  const DismissIntent();
}
