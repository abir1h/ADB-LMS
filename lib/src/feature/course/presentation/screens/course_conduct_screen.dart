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
import '../service/course_conduct_screen_service.dart';
import '../widgets/course_tab_section_widget.dart';
import '../../../video/presentation/service/video_service.dart';

class CourseConductScreen extends StatefulWidget {
  final Object? arguments;
  const CourseConductScreen({super.key, this.arguments})
      : assert(arguments != null && arguments is CourseConductScreenArgs);
  @override
  State<CourseConductScreen> createState() => _CourseConductScreenState();
}

class _CourseConductScreenState extends State<CourseConductScreen>
    with AppTheme, CourseConductScreenService, VideoService, AppEventsNotifier {

  // YoutubePlayerController? _youtubeController;
  VideoPlayerController? _controller;
  // ChewieController? _chewieController;
  final GlobalKey _bodyKey = GlobalKey();

  bool _onTouch = true;
  Timer? _timer;


  @override
  void initState() {
    super.initState();
    screenArgs = widget.arguments as CourseConductScreenArgs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadCourseTopicDetails(screenArgs.courseId!, screenArgs.topicId!);
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
              child: IconButton(onPressed: ()=>Navigator.pushNamed(context,AppRoute.notificationScreen), icon: Icon(
                Icons.notifications_sharp,
                color: clr.appPrimaryColorBlue,
              ),)
          )
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return AppStreamBuilder<CourseConductDataEntity>(
          stream: courseConductStreamController.stream,
          loadingBuilder: (context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          },
          dataBuilder: (context, data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.h16),
                !showVideo ? AspectRatio(
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
                        imageUrl:
                        ApiCredential.mediaBaseUrl+data.course!.imagePath,
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
                ) : const SizedBox(),


                if (showVideo) ...[
                  ///Activate solid video player
                  Stack(
                    fit: StackFit.loose,
                    children: [
                      ContentPlayerWidget(
                        playerStream:
                        videoDetailsDataStreamController.stream,
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
                      ////TODO: Change later
                      // AppStreamBuilder(
                      //     stream:
                      //     videoQuestionDataStreamController.stream,
                      //     loadingBuilder: (context) {
                      //       return Container();
                      //     },
                      //     dataBuilder: (context, data) {
                      //       return showOverlay
                      //           ? AspectRatio(
                      //         aspectRatio: MediaQuery.of(context)
                      //             .orientation ==
                      //             Orientation.portrait
                      //             ? 16 / 9
                      //             : 19 / 9,
                      //         child: OverlayMCQWidget(
                      //           items: data.choices,
                      //           data: data,
                      //           onTapSkip: onSkipInteractiveAction,
                      //           onTapSubmit: () {
                      //             VideoChoiceDataEntity choice =
                      //             data.choices.firstWhere(
                      //                     (element) =>
                      //                 element.isSelected ==
                      //                     true);
                      //             if (choice.isCorrect) {
                      //               CustomToasty.of(context)
                      //                   .showSuccess(label(
                      //                   e: "Your answer is correct",
                      //                   b: "আপনার উত্তর সঠিক"));
                      //             } else {
                      //               CustomToasty.of(context)
                      //                   .showWarning(label(
                      //                   e: "Your answer is wrong",
                      //                   b: "আপনার উত্তর ভুল"));
                      //             }
                      //             onSkipInteractiveAction();
                      //             data.seen=!data.seen;
                      //           },
                      //           builder: (BuildContext context,
                      //               int index, item) {
                      //             return OverlayMCQAnswerOptionWidget(
                      //               value: item.choiceText,
                      //               isSelected: item.isSelected,
                      //               onTap: () => setState(() {
                      //                 for (VideoChoiceDataEntity videoChoiceDataEntity
                      //                 in data.choices) {
                      //                   if (data.choices.indexOf(
                      //                       videoChoiceDataEntity) !=
                      //                       index) {
                      //                     videoChoiceDataEntity
                      //                         .isSelected = false;
                      //                   } else {
                      //                     videoChoiceDataEntity
                      //                         .isSelected =
                      //                     !videoChoiceDataEntity
                      //                         .isSelected;
                      //                   }
                      //                 }
                      //               }),
                      //             );
                      //           },
                      //         ),
                      //       )
                      //           : Container();
                      //     },
                      //     emptyBuilder: (context, message, icon) =>
                      //         Container()),
                      // Positioned(
                      //   top: 80,
                      //   left: .45.sw,
                      //   child: Visibility(
                      //     visible: _onTouch,
                      //     child:  GestureDetector(
                      //       onTap: (){
                      //         _timer?.cancel();
                      //
                      //         // pause while video is playing, play while video is pausing
                      //         setState(() {
                      //           _controller!.value.isPlaying ?
                      //           _controller!.pause() :
                      //           _controller!.play();
                      //         });
                      //
                      //         // Auto dismiss overlay after 1 second
                      //         _timer = Timer.periodic(Duration(milliseconds: 2000), (_) {
                      //           setState(() {
                      //             _onTouch = false;
                      //           });
                      //         });
                      //       },
                      //       child: CircleAvatar(
                      //           backgroundColor: Colors.grey.withOpacity(0.5),
                      //           radius: 25,
                      //           child: Icon(_controller!.value.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white,)),
                      //     ),
                      //
                      //
                      //   ),
                      // )
                    ],
                  )
                  // _controller!.value.isInitialized
                  //     ? Stack(
                  //   fit: StackFit.loose,
                  //   children: [
                  //     GestureDetector(
                  //       onTap: () {
                  //         setState(() {
                  //           _onTouch == true
                  //               ? _onTouch = false
                  //               : _onTouch = true;
                  //         });
                  //
                  //         /*  playVideo == true
                  //                 ? _controller!.pause()
                  //                 : _controller!.play();*/
                  //       },
                  //       child: AspectRatio(
                  //         aspectRatio: 16 / 9,
                  //         // child: VideoPlayer(_controller!),
                  //         //   child: Chewie(
                  //         //     controller: _chewieController!,
                  //         //   ),
                  //           child: ContentPlayerWidget(
                  //             playerStream: videoDetailsDataStreamController.stream,
                  //             playbackStream: playbackPausePlayStreamController.stream,
                  //             // onProgressChanged: onPlaybackProgressChanged,
                  //             // interceptSeekTo: onInterceptPlaybackSeekToPosition,
                  //             overlay: GestureDetector(
                  //               onTap: (){},
                  //               child: const Icon(Icons.arrow_back)
                  //             ),
                  //           ),
                  //       ),
                  //     ),
                  //     Positioned(
                  //         top: size.h16,
                  //         left: size.w16,
                  //         child: InkWell(
                  //           onTap: () {
                  //             Navigator.pop(context);
                  //           },
                  //           child: Icon(
                  //             Icons.arrow_back,
                  //             color: clr.shadeWhiteColor2,
                  //             size: size.r20,
                  //           ),
                  //         )),
                  //     // Positioned(
                  //     //   top: 80,
                  //     //   left: .45.sw,
                  //     //   child: Visibility(
                  //     //     visible: _onTouch,
                  //     //     child:  GestureDetector(
                  //     //       onTap: (){
                  //     //         _timer?.cancel();
                  //     //
                  //     //         // pause while video is playing, play while video is pausing
                  //     //         setState(() {
                  //     //           _controller!.value.isPlaying ?
                  //     //           _controller!.pause() :
                  //     //           _controller!.play();
                  //     //         });
                  //     //
                  //     //         // Auto dismiss overlay after 1 second
                  //     //         _timer = Timer.periodic(Duration(milliseconds: 2000), (_) {
                  //     //           setState(() {
                  //     //             _onTouch = false;
                  //     //           });
                  //     //         });
                  //     //       },
                  //     //       child: CircleAvatar(
                  //     //           backgroundColor: Colors.grey.withOpacity(0.5),
                  //     //           radius: 25,
                  //     //           child: Icon(_controller!.value.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white,)),
                  //     //     ),
                  //     //
                  //     //
                  //     //   ),
                  //     // )
                  //   ],
                  // )
                  //     : const Center(child: CircularProgressIndicator()),
                ] else if(isYoutube)...[
                  ///Activate Youtube video player
                  YoutubePlayerBuilder(
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
  void setYoutubeVideo(String url) {
    youtubeController = YoutubePlayerController(
      initialVideoId: url,
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
    setState(() {
      isYoutube = !isYoutube;
    });
  }

  @override
  void onEventReceived(EventAction action) {
    if (mounted) {
      if (action == EventAction.videoWidget) {
        setState(() {
          showVideo = !showVideo;
        });
      }
    }
  }
}
