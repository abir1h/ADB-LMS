import 'package:adb_mobile/src/core/service/notifier/app_events_notifier.dart';
import 'package:adb_mobile/src/core/utility/helper.dart';
import 'package:adb_mobile/src/feature/video/presentation/service/video_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/common_imports.dart';
import '../../domain/entities/course_conduct_data_entity.dart';
import '../../domain/entities/material_entity.dart';

class CourseTopicScreen extends StatefulWidget {
  final CourseConductDataEntity data;
  const CourseTopicScreen({super.key, required this.data});

  @override
  State<CourseTopicScreen> createState() => _CourseTopicScreenState();
}

class _CourseTopicScreenState extends State<CourseTopicScreen> with AppTheme {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: size.h12, horizontal: size.w12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [SubjectItemWidget(data: widget.data, onTap: () {})],
      ),
    );
  }
}

class SubjectItemWidget<T> extends StatefulWidget{
  final CourseConductDataEntity data;
  final VoidCallback onTap;
  const SubjectItemWidget({Key? key, required this.data, required this.onTap})
      : super(key: key);

  @override
  State<SubjectItemWidget<T>> createState() => _SubjectItemWidgetState<T>();
}

class _SubjectItemWidgetState<T> extends State<SubjectItemWidget<T>> with AppTheme, Language, VideoService{
  @override
  Widget build(BuildContext context) {
    widget.data.materials!.sort((a, b) => a.sequence.compareTo(b.sequence));
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.r4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.data.topic!.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: clr.blackColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    width: size.w10,
                  ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(
                  //       vertical: size.h6, horizontal: size.h6),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(size.r10),
                  //     color: clr.enterTrainingButtonColor,
                  //   ),
                  //   child: Center(
                  //     child: Text(
                  //       "পাঠ শুরু করুন",
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.w500,
                  //           fontSize: size.textXSmall,
                  //           color: clr.whiteColor),
                  //     ),
                  //   ),
                  // )
                ],
              ),
              SizedBox(
                height: size.h12,
              ),
              Text(
                "বিষয় অধ্যয়নের অগ্রগতি",
                style: TextStyle(
                  color: clr.textGrey,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: size.h4,
              ),
              LinearPercentIndicator(
                animation: true,
                lineHeight: 25.0,
                animationDuration: 2500,
                barRadius: Radius.circular(size.r10),
                percent: widget.data.progress / 100,
                center: Text(
                  "${widget.data.progress}%",
                  style: TextStyle(
                      color: clr.blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500),
                ),
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: clr.enterTrainingButtonColor,
                backgroundColor: clr.progressBgColor2,
              ),
              SizedBox(
                height: size.h10,
              ),
              Text(
                'Contents',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: size.textMedium,
                    color: clr.blackColor),
              ),
              SizedBox(
                height: size.h10,
              ),
              TopicSectionWidget(
                  items: widget.data.materials!,
                  buildItem: (BuildContext context, int index, item) {
                    return TopicItemWidget(
                      data: item,
                      onTap: (){

                        loadVideoData(item);

                      },
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  @override
  void changeOrientationToPortrait() {
    // TODO: implement changeOrientationToPortrait
  }

  @override
  bool isPlayerFullscreen() {
    // TODO: implement isPlayerFullscreen
    throw UnimplementedError();
  }

  @override
  void navigateToBack() {
    // TODO: implement navigateToBack
  }


  @override
  void showWarning(String message) {
    // TODO: implement showWarning
  }


}

class TopicSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const TopicSectionWidget(
      {super.key, required this.items, required this.buildItem});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return buildItem(context, index, items[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: size.h2,
        );
      },
    );
  }
}

class TopicItemWidget<T> extends StatelessWidget with AppTheme, Language {
  final MaterialEntity data;
  final VoidCallback onTap;
  const TopicItemWidget({Key? key, required this.data, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: clr.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.5),
                  blurRadius: 8.w,
                  offset: Offset(0.0, 2.w),
                ),
              ],
              borderRadius: BorderRadius.circular(size.r8),
            ),
            child: Row(
              children: [
                data.type != "Video"
                    ? Expanded(
                        flex: 0,
                        child: FaIcon(FontAwesomeIcons.clock,
                            color: clr.appPrimaryColorBlue))
                    : Expanded(
                        flex: 0,
                        child: FaIcon(FontAwesomeIcons.solidCirclePlay,
                            color: clr.appPrimaryColorBlue)),
                SizedBox(
                  width: size.w16,
                ),
                data.type == "Video"
                    ? Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.title,
                              maxLines: 2,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: size.textXSmall,
                                  color: clr.textGrey),
                            ),
                            Text(
                              Helper.secondToMin(data.videoDurationSecond),
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: size.textXSmall,
                                  color: clr.appPrimaryColorBlue),
                            ),
                          ],
                        ),
                      )
                    : GestureDetector(
                        onTap: onTap,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: size.h10, horizontal: size.h10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(size.r10),
                            color: clr.enterTrainingButtonColor,
                          ),
                          child: Center(
                            child: Text(
                              data.type,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.textXSmall,
                                  color: clr.whiteColor),
                            ),
                          ),
                        ),
                      ),
                data.type == "Video" ? const SizedBox() : const Spacer(),
                // Expanded(
                //     flex: 2,
                //     child: Row(
                //       children: [
                //         Expanded(
                //           child: Text(
                //             data.title,
                //             maxLines: 2,
                //             style: TextStyle(
                //                 fontWeight: FontWeight.w600,
                //                 fontSize: size.textXSmall,
                //                 color: clr.textGrey),
                //           ),
                //         ),
                //       ],
                //     )),
                SizedBox(
                  width: size.w6,
                ),
                data.restricted
                    ? Expanded(
                        flex: 0,
                        child: Icon(FontAwesomeIcons.lock,
                            color: clr.appPrimaryColorBlue))
                    : const SizedBox(),
                SizedBox(
                  width: size.w6,
                ),
                data.studied
                    ? Expanded(
                        flex: 0,
                        child: FaIcon(FontAwesomeIcons.check,
                            color: clr.appPrimaryColorBlue))
                    : const SizedBox(),
                SizedBox(
                  width: size.w6,
                ),
                // Expanded(
                //   flex: 0,
                //   child: CircularPercentIndicator(
                //     radius: 30.0,
                //     lineWidth: 6.0,
                //     percent: data.progress / 100,
                //     center: Text(
                //       "${data.progress.floor()}%",
                //       style: TextStyle(
                //           fontWeight: FontWeight.w600, color: clr.blackColor),
                //     ),
                //     progressColor: clr.enterTrainingButtonColor,
                //   ),
                // ),
              ],
            )),
      ),
    );
  }
}
