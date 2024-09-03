import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/service/notifier/app_events_notifier.dart';
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
        leading: IconButton(
          onPressed: () => onTapLeadingBack(),
          icon: const Icon(Icons.arrow_back),
          color: clr.blackColor,
        ),
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
                SizedBox(height: size.h10),
                AspectRatio(
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
                            ApiCredential.mediaBaseUrl + data.course!.imagePath,
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
                ),
                SizedBox(height: size.h10),
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
      if (action == EventAction.videoWidget) {}
      if (action == EventAction.showYoutube) {}
      if (action == EventAction.loadConductScreen) {
        loadCourseTopicDetails(screenArgs.courseId!, screenArgs.topicId!);
      }
    }
  }

  @override
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
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
