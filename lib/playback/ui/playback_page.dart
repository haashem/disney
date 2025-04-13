import 'package:disney/playback/ui/scrub_bar.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: const Text('Playback'),
        backgroundColor: Colors.transparent,
        elevation: 10,
        shadowColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body:
          // _controller.value.isInitialized
          //     ? AspectRatio(
          //         aspectRatio: _controller.value.aspectRatio,
          //         child: Stack(
          //             fit: StackFit.expand,
          //             alignment: Alignment.bottomCenter,
          //             children: [
          //               VideoPlayer(_controller),
          //               VideoPlayerControls(controller: _controller),
          //             ]),
          //       )
          //     : CircularProgressIndicator(),
          Stack(
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
  final Duration seekDuration = const Duration(seconds: 10);
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

  void pause() {
    widget.controller.pause();
    //onPause?.call();
  }

  void play() {
    widget.controller.play();
    //onPlay?.call();
  }

  String get remainingTime {
    final duration = widget.controller.value.duration;
    final position = widget.controller.value.position;
    final remaining = duration - position;
    return remaining.toString().split('.').first;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
    );
  }
}
