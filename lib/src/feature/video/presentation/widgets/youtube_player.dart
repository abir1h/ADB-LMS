import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/constants/common_imports.dart';

class CustomYoutubePlayer extends StatefulWidget {
  final String videoUrl;
  final Widget body;

  const CustomYoutubePlayer(
      {super.key, required this.videoUrl, required this.body});

  @override
  State<CustomYoutubePlayer> createState() => _CustomYoutubePlayerState();
}

class _CustomYoutubePlayerState extends State<CustomYoutubePlayer>
    with AppTheme {
  YoutubePlayerController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoUrl,
      flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: false,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
          showLiveFullscreenButton: true),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (pop) async {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

        return;
      },
      child: OrientationBuilder(
        builder: (context, orientation) {
          // Adjust UI based on orientation (portrait or landscape)
          // ...
          orientation == Orientation.portrait
              ? SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                  overlays: [
                      SystemUiOverlay.top,
                    ])
              : null;
          return YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller!,
              aspectRatio: 16 / 9,
              showVideoProgressIndicator: true,
              progressColors: ProgressBarColors(
                  backgroundColor: clr.progressBGColor,
                  playedColor: clr.appPrimaryColorBlue,
                  handleColor: clr.appPrimaryColorBlue),
            ),
            builder: (context, player) {
              return Column(
                children: [
                  Stack(
                    fit: StackFit.loose,
                    children: [
                      player,
                      Positioned(
                          top: size.h16,
                          left: size.w16,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: clr.shadeWhiteColor2,
                              size: size.r20,
                            ),
                          ))
                    ],
                  ),
                  widget.body
                ],
              );
            },
          );
        },
      ),
    );
  }
}
