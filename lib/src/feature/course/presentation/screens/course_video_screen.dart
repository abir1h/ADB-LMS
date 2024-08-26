import 'dart:async';

import 'package:adb_mobile/src/core/service/notifier/app_events_notifier.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../video/presentation/widgets/content_player_widget.dart';
import '../../../../core/constants/app_theme.dart';
import '../../domain/entities/course_conduct_data_entity.dart';
import '../../domain/entities/material_entity.dart';
import '../service/course_conduct_screen_service.dart';
import '../service/course_video_screen_service.dart';
import '../widgets/course_tab_section_widget.dart';
import '../../../video/presentation/service/video_service.dart';

class CourseVideoScreen extends StatefulWidget {
  final Object? arguments;
  const CourseVideoScreen({super.key, this.arguments})
      : assert(arguments != null && arguments is CourseVideoScreenArgs);
  @override
  State<CourseVideoScreen> createState() => _CourseVideoScreenState();
}

class _CourseVideoScreenState extends State<CourseVideoScreen>
    with AppTheme, CourseVideoScreenService, VideoService, AppEventsNotifier {
  // YoutubePlayerController? _youtubeController;
  VideoPlayerController? _controller;
  // ChewieController? _chewieController;
  final GlobalKey _bodyKey = GlobalKey();

  bool _onTouch = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    screenArgs = widget.arguments as CourseVideoScreenArgs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadCourseTopicDetails(screenArgs.courseId!, screenArgs.topicId!);
      if (screenArgs.data.youtubeId.isNotEmpty) {
        showYoutubePlayer(screenArgs.data).then((v) {
          setState(() {
            showVideo = false;
            isYoutube = true;
          });
        });
      } else {
        videoDetailsDataStreamController
            .add(DataLoadedState<MaterialEntity>(screenArgs.data));
        setState(() {
          showVideo = true;
          isYoutube = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clr.scaffoldBackgroundColor,
      appBar: AppBar(
        leadingWidth: size.w40,
        title: Text(
          "প্রশিক্ষণ",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: size.textSmall,
              color: clr.appPrimaryColorBlue),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoute.notificationScreen),
                icon: Icon(
                  Icons.notifications_sharp,
                  color: clr.appPrimaryColorBlue,
                ),
              ))
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return AppStreamBuilder<CourseConductDataEntity>(
          stream: courseConductStreamController.stream,
          loadingBuilder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          dataBuilder: (context, data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.h16),
                !showVideo && !isYoutube
                    ? AspectRatio(
                        aspectRatio: 16 / 8,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(8.r),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(8.r),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: ApiCredential.mediaBaseUrl +
                                  data.course!.imagePath,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
                if (showVideo && !isYoutube) ...[
                  ///Activate solid video player
                  Stack(
                    fit: StackFit.loose,
                    children: [
                      ContentPlayerWidget(
                        playerStream: videoDetailsDataStreamController.stream,
                        playbackStream:
                            playbackPausePlayStreamController.stream,
                        // onProgressChanged: onPlaybackProgressChanged,
                        // interceptSeekTo: onInterceptPlaybackSeekToPosition,
                      ),
                      Positioned(
                          top: size.h16,
                          left: size.w16,
                          child: InkWell(
                            onTap: onGoBack,
                            child: Icon(
                              Icons.arrow_back,
                              color: clr.shadeWhiteColor2,
                              size: size.r20,
                            ),
                          )),
                    ],
                  )
                ] else if (!showVideo && isYoutube) ...[
                  ///Activate Youtube video player
                  youtubeController != null
                      ? YoutubePlayerBuilder(
                          player: YoutubePlayer(
                            controller: youtubeController!,
                            aspectRatio: 16 / 9,
                            showVideoProgressIndicator: true,
                            progressColors: ProgressBarColors(
                                backgroundColor: clr.progressBGColor,
                                playedColor: clr.iconColorRed,
                                handleColor: clr.iconColorRed),
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
                              ],
                            );
                          },
                        )
                      : const CircularProgressIndicator()
                ],
                SizedBox(height: size.h16),
                CourseTabSectionWidget(
                  tabTitle1: "বিষয়বস্তু",
                  tabTitle2: "বিস্তারিত",
                  tabTitle3: 'আলোচনা',
                  tabTitle4: "FAQ",
                  courseConductDataEntity: data,
                ),
              ],
            );
          },
          emptyBuilder: (context, message, icon) => Padding(
              padding: EdgeInsets.all(size.h24),
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Lottie.asset(ImageAssets.animEmpty, height: size.h64 * 3),
                  SizedBox(height: size.h8),
                  Text(
                    message,
                    style: TextStyle(
                      color: clr.blackColor,
                      fontSize: size.textSmall,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ]),
              )),
        );
      }),
    );
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }

  @override
  void changeOrientationToPortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  bool isPlayerFullscreen() {
    return MediaQuery.of(context).orientation != Orientation.portrait;
  }

  @override
  void navigateToBack() {
    Navigator.of(context).pop();
  }

  @override
  void onEventReceived(EventAction action) {
    if (mounted) {
      if (action == EventAction.videoWidget) {
        setState(() {
          showVideo = true;
          isYoutube = false;
        });
      }
      if (action == EventAction.showYoutube) {}
    }
  }

  Future showYoutubePlayer(MaterialEntity data) async {
    youtubeController = YoutubePlayerController(
      initialVideoId: data.youtubeId,
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

// Future showYoutubePlayer() async {
//   youtubeController = YoutubePlayerController(
//     initialVideoId: materialData!.youtubeId.toString(),
//     flags: const YoutubePlayerFlags(
//         mute: false,
//         autoPlay: false,
//         disableDragSeek: false,
//         loop: false,
//         isLive: false,
//         forceHD: false,
//         enableCaption: true,
//         showLiveFullscreenButton: true),
//   );
// }
}
