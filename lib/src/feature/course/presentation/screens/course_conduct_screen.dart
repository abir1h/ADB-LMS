import 'package:adb_mobile/src/core/constants/app_theme.dart';
import 'package:adb_mobile/src/feature/course/domain/entities/course_conduct_data_entity.dart';
import 'package:adb_mobile/src/feature/course/presentation/service/course_conduct_screen_service.dart';
import 'package:adb_mobile/src/feature/course/presentation/widgets/course_tab_section_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route_args.dart';
import '../widgets/tab_section_widget.dart';

class CourseConductScreen extends StatefulWidget {
  final Object? arguments;
  const CourseConductScreen({super.key, this.arguments})
      : assert(arguments != null && arguments is CourseConductScreenArgs);
  @override
  State<CourseConductScreen> createState() => _CourseConductScreenState();
}

class _CourseConductScreenState extends State<CourseConductScreen>
    with AppTheme, CourseConductScreenService {

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
            child: Icon(
              Icons.notifications_sharp,
              color: clr.appPrimaryColorBlue,
            ),
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
                ),
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
    // TODO: implement showWarning
  }
}
