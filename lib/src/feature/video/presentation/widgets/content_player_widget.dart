import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../course/domain/entities/material_entity.dart';
import 'video_player.dart';

class ContentPlayerWidget extends StatefulWidget {
  final Stream<DataState<MaterialEntity>> playerStream;
  final Stream<DataState<bool>> playbackStream;
  final Widget? overlay;

  final double Function(MaterialEntity currentContent,
      double seekPosition, double totalDuration)? interceptSeekTo;
  final void Function(MaterialEntity currentContent,
      double playedPosition, double totalDuration)? onProgressChanged;

  const ContentPlayerWidget({
    Key? key,
    required this.playerStream,
    required this.playbackStream,
    this.overlay,
    this.interceptSeekTo,
    this.onProgressChanged,
  }) : super(key: key);

  @override
  State<ContentPlayerWidget> createState() => _CustomPlayerWidgetState();
}

class _CustomPlayerWidgetState extends State<ContentPlayerWidget> {
  final ContentVideoPlayerController _playerController =
      ContentVideoPlayerController();

  // VideoDataEntity _currentContent = VideoContentViewModel.empty();
  late MaterialEntity _currentContent;
  StreamSubscription<DataState<MaterialEntity>>? _subscription;
  StreamSubscription<DataState<bool>>? _playbackSubscription;

  @override
  void initState() {
    _playerController.interceptSeekTo = _interceptSeekTo;
    _playerController.onProgressChange = _onProgressChanged;
    _subscription = widget.playerStream.listen(_onPlayVideo);
    _playbackSubscription = widget.playbackStream.listen(_onPlaybackChange);
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _playerController.dispose();
    _playbackSubscription?.cancel();
    super.dispose();
  }

  void _onPlayVideo(DataState<MaterialEntity> event) {
    if (!mounted) return;
    _currentContent = (event as DataLoadedState<MaterialEntity>).data;
    _playerController.play(
        // getVideoFileUrl(
        //     ApiCredential.mediaBaseUrl + _currentContent.filePath),
          getVideoFileUrl('https://bbadb.bacbonltd.net/core/Files/CourseTopicMaterial/Videos/VIDSKCE20240424142902.mp4'),
        //   getVideoFileUrl("http://116.204.155.53/video/7b54b930-2fba-46d1-8741-50a60cb9ecdf.mp4"),

        autoPlay: true,
        ///TODO:Change It
        // playPosition:
        //     Duration(seconds: _currentContent.videoActivityData != null ? _currentContent.videoActivityData!.lastViewTime : 0)




        // playPosition:Duration(seconds: _currentContent.lastPlayedDurationTimeSec)
        // _currentContent.playedDurationTimeSec < _currentContent.videoDurationSecond
        //     ? Duration(seconds: _currentContent.playedDurationTimeSec)
        //     : null,
        );
  }

  void _onPlaybackChange(DataState<bool> event) {
    var data = (event as DataLoadedState<bool>).data;
    if (data) {
      _playerController.resume();
    } else {
      _playerController.pause();
    }
  }

  double _interceptSeekTo(double seekPosition, double totalDuration) {
    return widget.interceptSeekTo
            ?.call(_currentContent, seekPosition, totalDuration) ??
        seekPosition;
  }

  void _onProgressChanged(double playedPosition, double totalDuration) {
    widget.onProgressChanged
        ?.call(_currentContent, playedPosition, totalDuration);
  }

  @override
  Widget build(BuildContext context) {
    return CustomVideoPlayer(
      controller: _playerController,
      overlay: Align(alignment: Alignment.topLeft, child: widget.overlay),
    );
  }
}

String getVideoFileUrl(String filePath) {
  if (filePath.isEmpty) return "";
  return filePath;
}

// class VideoContentViewModel extends ContentEntity{
//   VideoContentViewModel.fromJson(Map<String, dynamic> json) : super.fromJson(json);
//   VideoContentViewModel.empty() : super.empty();
// }
