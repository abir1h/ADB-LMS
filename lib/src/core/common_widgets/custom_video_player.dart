import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../constants/app_theme.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String videoUrl;
  const CustomVideoPlayer({super.key, required this.videoUrl});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> with AppTheme {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          VideoPlayer(
            _controller,
          ),
          if (_controller.value.isInitialized)
            GestureDetector(
              onTap: () {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
                setState(() {});
              },
              child: Center(
                child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: clr.greyColor,
                  size: size.r28 + size.r28,
                ),
              ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.w16, vertical: size.h20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: VideoProgressIndicator(_controller,
                        allowScrubbing: true,
                        colors: const VideoProgressColors(
                          backgroundColor: Colors.grey,
                          playedColor: Colors.red,
                        )),
                  ),
                  SizedBox(width: size.w8),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.video_settings,
                      color: Colors.white,
                      size: size.r28,
                    ),
                  ),
                  SizedBox(width: size.w8),
                  GestureDetector(
                    // onTap: _toggleOrientation,
                    child: Icon(
                      Icons.fullscreen,
                      color: Colors.white,
                      size: size.r28,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _toggleOrientation() {
    if (mounted) {
      setState(() {
        if (MediaQuery.of(context).orientation == Orientation.landscape) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);
        } else {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
          ]);
        }
      });
    }
  }
}
