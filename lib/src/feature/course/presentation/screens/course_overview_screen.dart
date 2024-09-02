import 'package:adb_mobile/src/core/constants/app_theme.dart';
import 'package:adb_mobile/src/feature/course/domain/entities/course_overview_data_entity.dart';
import 'package:adb_mobile/src/feature/course/presentation/service/course_overview_screen_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../widgets/tab_section_widget.dart';

class CourseOverViewScreen extends StatefulWidget {
  final Object? arguments;
  const CourseOverViewScreen({Key? key, this.arguments})
      : assert(arguments != null && arguments is CourseDetailsScreenArgs),
        super(key: key);
  @override
  State<CourseOverViewScreen> createState() => _CourseOverViewScreenState();
}

class _CourseOverViewScreenState extends State<CourseOverViewScreen>
    with AppTheme, CourseOverViewScreenService {
  CourseDetailsScreenArgs? _courseDetailsScreenArgs;

  @override
  void initState() {
    _courseDetailsScreenArgs = widget.arguments as CourseDetailsScreenArgs?;
    super.initState();
    loadCourses(_courseDetailsScreenArgs!.data!.id);
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
        return AppStreamBuilder<CourseOverViewDataEntity>(
          stream: courseStreamController.stream,
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.h16),
                  child: Text(
                    data.title,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: clr.blackColor,
                        fontSize: size.textLarge),
                  ),
                ),
                SizedBox(height: size.h16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.h16),
                  child: Container(
                    padding: EdgeInsets.all(size.h16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.r10),
                        color: clr.progressBgColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "প্রশিক্ষণের অগ্রগতি",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: clr.appPrimaryColorBlue,
                              fontSize: size.textMedium),
                        ),
                        SizedBox(
                          height: size.h8,
                        ),
                        LinearPercentIndicator(
                          animation: true,
                          lineHeight: 20.0,
                          animationDuration: 500,
                          barRadius: Radius.circular(size.r10),
                          percent: data.progress / 100,
                          center: Text(
                            "${data.progress}%",
                            style: TextStyle(
                                color: clr.blackColor,
                                fontWeight: FontWeight.w500),
                          ),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: clr.enterTrainingButtonColor,
                          backgroundColor: clr.progressBgColor2,
                        ),
                        /*LinearProgressIndicator(
                          minHeight: 20.h,
                          value: data.progress / 100,
                          color: clr.enterTrainingButtonColor,
                          backgroundColor: clr.progressBgColor2,
                          borderRadius: BorderRadius.circular(size.r4),
                        )*/
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.h16),
                TabSectionWidget(
                  tabTitle1: "বিষয় সমূহ",
                  tabTitle2: "বিস্তারিত",
                  tabTitle3: 'আলোচনা',
                  tabTitle4: "FAQ",
                  courseOverViewDataEntity: data,
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
