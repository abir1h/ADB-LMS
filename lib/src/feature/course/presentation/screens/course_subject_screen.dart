import 'package:adb_mobile/src/core/common_widgets/app_dropdown_widget.dart';
import 'package:adb_mobile/src/feature/course/domain/entities/course_overview_data_entity.dart';
import 'package:adb_mobile/src/feature/course/domain/entities/material_data_entity.dart';
import 'package:adb_mobile/src/feature/course/domain/entities/topic_data_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/common_imports.dart';

class CourseSubjectScreen extends StatefulWidget {
  final CourseOverViewDataEntity data;
  const CourseSubjectScreen({super.key, required this.data});

  @override
  State<CourseSubjectScreen> createState() => _CourseSubjectScreenState();
}

class _CourseSubjectScreenState extends State<CourseSubjectScreen>
    with AppTheme {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: size.h12, horizontal: size.w12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'বিষয় সমূহ',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: size.textLarge,
                color: clr.appPrimaryColorBlue),
          ),
          SubjectSectionWidget(
              items: widget.data.topics,
              buildItem: (BuildContext context, int index, item) {
                return SubjectItemWidget(
                  data: item,
                  onTap: () {},
                );
              })
        ],
      ),
    );
  }
}

class SubjectSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const SubjectSectionWidget(
      {Key? key, required this.items, required this.buildItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          itemCount: items.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return buildItem(context, index, items[index]);
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: clr.greyColor,
            );
          },
        ),
      ],
    );
  }
}

class SubjectItemWidget<T> extends StatelessWidget with AppTheme, Language {
  final TopicDataEntity data;
  final VoidCallback onTap;
  const SubjectItemWidget({Key? key, required this.data, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                      data.title,
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
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: size.h6, horizontal: size.h6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.r10),
                      color: clr.enterTrainingButtonColor,
                    ),
                    child: Center(
                      child: Text(
                        "পাঠ শুরু করুন",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: size.textXSmall,
                            color: clr.whiteColor),
                      ),
                    ),
                  )
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
                percent: data.progress / 100,
                center: Text(
                  "${data.progress}%",
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
              TopicSectionWidget(
                  items: data.materials,
                  buildItem: (BuildContext context, int index, item) {
                    return TopicItemWidget(
                      data: item,
                      onTap: () {},
                    );
                  })
            ],
          ),
        ),
      ),
    );
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
        return SizedBox(height: size.h2,);
      },
    );
  }
}

class TopicItemWidget<T> extends StatelessWidget with AppTheme, Language {
  final MaterialDataEntity data;
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
              borderRadius: BorderRadius.circular(size.r4),
            ),
            child: Row(
              children: [
                const Expanded(
                    flex: 0,
                    child: FaIcon(FontAwesomeIcons.solidCirclePlay)),SizedBox(width: size.w8,),
                Expanded(flex: 2,
                    child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        data.title,
                        maxLines: 2,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: size.textXSmall,
                            color: clr.textGrey),
                      ),
                    ),
                  ],
                )),SizedBox(width: size.w6,),
                Expanded(
                  flex: 0,
                  child: CircularPercentIndicator(
                    radius: 30.0,
                    lineWidth: 6.0,
                    percent: data.progress/100,
                    center:  Text("${data.progress.floor()}%",style: TextStyle(fontWeight: FontWeight.w600,color: clr.blackColor),),
                    progressColor: clr.enterTrainingButtonColor,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}