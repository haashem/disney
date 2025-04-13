import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ScrubBar extends StatefulWidget {
  const ScrubBar({super.key, required this.controller});

  final VideoPlayerController controller;

  @override
  State<ScrubBar> createState() => _ScrubBarState();
}

class _ScrubBarState extends State<ScrubBar> {
  double playheadPosition = 0;
  bool isSeeking = false;
  CancelableOperation<void>? _seeking;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(positionChanged);
  }

  void positionChanged() {
    setState(() {
      if (isSeeking) return;
      playheadPosition = widget.controller.value.position.inSeconds.toDouble();
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(positionChanged);
    _seeking?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;

    return Row(
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: _TimeElapsed(value: controller.value)),
        ),
        Expanded(
          child: Slider(
            padding: EdgeInsets.all(0),
            value: playheadPosition,
            label:
                '${controller.value.position.inMinutes}:${controller.value.position.inSeconds.remainder(60)}',
            max: controller.value.duration.inSeconds.toDouble(),
            onChangeStart: (value) {
              _seeking?.cancel();
              isSeeking = true;
            },
            onChanged: (value) {
              setState(() {
                playheadPosition = value;
              });
            },
            onChangeEnd: (value) {
              _seeking?.cancel();

              final seekOperation = CancelableOperation.fromFuture(
                widget.controller.seekTo((Duration(seconds: value.toInt()))),
              );
              _seeking = seekOperation.then((_) {
                isSeeking = false;
                _seeking = null;
              });
            },
          ),
        ),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: _TimeRemaining(value: controller.value)),
        ),
      ],
    );
  }
}

class _TimeElapsed extends StatelessWidget {
  const _TimeElapsed({required this.value});

  final VideoPlayerValue value;

  @override
  Widget build(BuildContext context) {
    return _DisplayTime(time: value.position);
  }
}

class _TimeRemaining extends StatelessWidget {
  const _TimeRemaining({required this.value});

  final VideoPlayerValue value;

  @override
  Widget build(BuildContext context) {
    final remaining = value.duration - value.position;

    return _DisplayTime(time: remaining);
  }
}

class _DisplayTime extends StatelessWidget {
  const _DisplayTime({required this.time});

  final Duration time;

  @override
  Widget build(BuildContext context) {
    final text = "$time".split('.').first;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
