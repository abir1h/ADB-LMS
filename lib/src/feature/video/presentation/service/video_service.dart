import 'package:flutter/material.dart';

import '../../../../core/service/local_database_service.dart';
import '../../../course/domain/entities/material_entity.dart';
import '../../../../core/service/notifier/app_events_notifier.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../course/domain/entities/popup_quiz_data_model.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
  void navigateToBack();
  bool isPlayerFullscreen();
  void changeOrientationToPortrait();
}

mixin VideoService<T extends StatefulWidget> on State<T> implements _ViewModel {
  late _ViewModel _view;

  int currentPlayedPositionSec = 0;
  bool showOverlay = false;
  String _guid = "";
  bool showVideo = false;
  bool isYoutube = false;
  VideoData? data = VideoData();
  String? videoUrl;
  VideoWatchSession _watchSession = VideoWatchSession.empty();

  // Future<ResponseEntity> contentRead(
  //     int contentId,
  //     String contentType,
  //     int courseId,
  //     bool isCompleted,
  //     String lastWatchTime,
  //     String attendanceType) async {
  //   return _courseUseCase.contentReadUseCase(contentId, contentType, courseId,
  //       isCompleted, lastWatchTime, attendanceType);
  // }

  // Future<ResponseEntity> videoActivity(int circularVideoId, int lastWatchTime,
  //     List<int> questionSeenList) async {
  //   return _videoUseCase.videoActivityUseCase(
  //       circularVideoId, lastWatchTime, questionSeenList);
  // }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    videoDetailsDataStreamController.dispose();
    playbackPausePlayStreamController.dispose();
    super.dispose();
  }

  ///Stream controllers
  final AppStreamController<MaterialEntity> videoDetailsDataStreamController =
      AppStreamController();
  final AppStreamController<bool> playbackPausePlayStreamController =
      AppStreamController();

  ///TODO: Change Later
  final AppStreamController<PopupQuizDataEntity>
      videoQuestionDataStreamController = AppStreamController();

  _getVideoWatchSessions(int circularVideoId) async {
    await LocalDatabase.instance
        .getLectureWatchSessions()
        .then((history) async {
      if (history.isNotEmpty) {
        var data = history
            .where((element) => element.circularVideoId == circularVideoId)
            .toList();
        if (data.isNotEmpty) {
          _watchSession = data[0];
        }
      }
    });
  }

  ///Load Video details
  // void loadVideoData(int courseContentId) {
  //   _getVideoWatchSessions(screenArgs.data.contentId);
  //   if (!mounted) return;
  //   videoDetailsDataStreamController.add(LoadingState());
  //   getVideoDetails(courseContentId).then((value) {
  //     if (value.error == null &&
  //         value.data != null &&
  //         value.data.videoData != null) {
  //       videoDetailsDataStreamController
  //           .add(DataLoadedState<VideoContentDataEntity>(value.data));
  //       if (value.data.videoData.category != VideoCategory.s3.name) {
  //         _view.setYoutubeVideo(value.data.videoData.videoUrl);
  //       }
  //     } else if (value.error == null && value.data == null) {
  //       _view.showWarning(value.message!);
  //       videoDetailsDataStreamController.add(EmptyState(message: ""));
  //     } else {
  //       _view.showWarning(value.message!);
  //     }
  //   });
  // }

  void loadVideoData(
    MaterialEntity materialEntity,
    String courseId,
    String topicId,
  ) {
    // if (!mounted) return;
    // videoDetailsDataStreamController.add(LoadingState());

    if (materialEntity.youtubeId.isNotEmpty) {
      //youtube
      Navigator.pushReplacementNamed(context, AppRoute.courseVideoScreen,
          arguments: CourseVideoScreenArgs(
              data: materialEntity, courseId: courseId, topicId: topicId));
    } else {
      Navigator.pushReplacementNamed(context, AppRoute.courseVideoScreen,
          arguments: CourseVideoScreenArgs(
              data: materialEntity, courseId: courseId, topicId: topicId));
    }
  }

  // double onInterceptPlaybackSeekToPosition(
  //     MaterialEntity currentContent,
  //     double seekPosition,
  //     double totalDuration) {
  //   return currentContent.videoActivityData!.lastViewTime * 1000 >= seekPosition
  //       ? seekPosition
  //       : (currentContent.videoActivityData!.lastViewTime * 1000).toDouble();
  // }
  ///Change video playback orientation
  Future<bool> onGoBack() async {
    if (_view.isPlayerFullscreen()) {
      _view.changeOrientationToPortrait();
    }
    _view.navigateToBack();
    // videoActivity(_watchSession.circularVideoId,
    //         _watchSession.lastPlayedDuration, _watchSession.videoQuestionSeenId)
    //     .then((value) {
    //   if (value.error == null) {}
    // });
    return Future.value(false);
  }

  void onPlaybackProgressChanged(MaterialEntity currentContent,
      double playedPosition, double totalDuration) {
    int playedPositionSec = (playedPosition ~/ 1000).round();
    if (currentPlayedPositionSec != playedPositionSec) {
      currentPlayedPositionSec = playedPositionSec;
      PopupQuizDataEntity? questionData = currentContent.popupQuizzes
          .singleWhere((element) => element.timeSpan == playedPositionSec,
              orElse: () => PopupQuizDataEntity(
                    timeSpan: -1,
                    hour: -1,
                    minute: -1,
                    second: -1,
                    question: "",
                    option1: "",
                    option2: "",
                    option3: "",
                    option4: "",
                    answers: "",
                    mark: -1,
                    examId: "",
                    exam: "",
                    updated: false,
                    createdDate: "",
                    createdBy: "",
                    modifiedDate: "",
                    modifiedBy: "",
                    id: "",
                  ));
      if (questionData.id.isNotEmpty) {
        debugPrint("pop question");
        showOverlay = true;
        AppEventsNotifier.notify(EventAction.showPopQuiz);
        videoQuestionDataStreamController
            .add(DataLoadedState<PopupQuizDataEntity>(questionData));
        playbackPausePlayStreamController.add(DataLoadedState<bool>(false));
      }
    }
    // if (currentContent.videoActivityData == null) {
    //   _watchSession = VideoWatchSession(
    //       circularVideoId: screenArgs.data.contentId,
    //       startTime: "",
    //       endTime: "",
    //       guid: _guid,
    //       totalDuration: 324,
    //       lastPlayedDuration: playedPositionSec,
    //       videoQuestionSeenId: (videoDetailsDataStreamController.value
    //               as DataLoadedState<VideoContentDataEntity>)
    //           .data
    //           .videoQuestion!
    //           .where((item) => item.seen)
    //           .map((data) => data.id)
    //           .toList());
    //   _storeActualWatchedSession();
    // } else {
    //   if (currentContent.videoActivityData!.lastViewTime < playedPositionSec) {
    //     currentContent.videoActivityData!.lastViewTime =
    //         currentContent.videoActivityData!.lastViewTime < playedPositionSec
    //             ? playedPositionSec
    //             : currentContent.videoActivityData!.lastViewTime;
    //     _watchSession = VideoWatchSession(
    //         circularVideoId: screenArgs.data.contentId,
    //         startTime: "",
    //         endTime: "",
    //         guid: _guid,
    //         totalDuration: 324,
    //         lastPlayedDuration: currentContent.videoActivityData!.lastViewTime,
    //         videoQuestionSeenId: (videoDetailsDataStreamController.value
    //                 as DataLoadedState<VideoContentDataEntity>)
    //             .data
    //             .videoQuestion!
    //             .where((item) => item.seen)
    //             .map((data) => data.id)
    //             .toList());
    //     _storeActualWatchedSession();
    //   }
    // }
  }

  void onTapPopupQuizSubmit(PopupQuizDataEntity data) {
    bool isCorrectAnswer = false;
    String correctAnswerText = "";
    final correctAnswers = <int>[];
    if (data.answers.contains(",")) {
      List<String> answerData = data.answers.split(",");
      for (String element in answerData) {
        if (element.isNotEmpty) {
          correctAnswers.add(int.parse(element));
        }
      }
    } else {
      correctAnswers.add(int.parse(data.answers));
    }
    for (int correctAnswer in correctAnswers) {
      if (correctAnswer == 1) {
        if (data.isOption1Selected) {
          isCorrectAnswer = true;
        }
        correctAnswerText = data.option1;
      } else if (correctAnswer == 2) {
        if (data.isOption2Selected) {
          isCorrectAnswer = true;
        }
        correctAnswerText = data.option2;
      } else if (correctAnswer == 3) {
        if (data.isOption3Selected) {
          isCorrectAnswer = true;
        }
        correctAnswerText = data.option3;
      } else if (correctAnswer == 4) {
        if (data.isOption4Selected) {
          isCorrectAnswer = true;
        }
        correctAnswerText = data.option4;
      } else {
        isCorrectAnswer = false;
      }
    }
    if (isCorrectAnswer) {
      _view.showSuccess("আপনার উত্তর সঠিক");
    } else {
      _view.showWarning("আপনার উত্তর ভুল। সঠিক উত্তর: $correctAnswerText");
    }
    onSkipInteractiveAction();
  }

  void onSkipInteractiveAction() {
    showOverlay = false;
    AppEventsNotifier.notify(EventAction.showPopQuiz);
    playbackPausePlayStreamController.add(DataLoadedState<bool>(true));
  }

  Future<void> _storeActualWatchedSession() async {
    try {
      await LocalDatabase.instance.storeLectureWatchSession(_watchSession);
      //   }
    } catch (_) {
      print(_);
    }
  }
}

class VideoData {
  String? url;

  VideoData({
    this.url,
  });
}
