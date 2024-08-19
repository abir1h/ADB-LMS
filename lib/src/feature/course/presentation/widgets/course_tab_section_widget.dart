import 'package:flutter/material.dart';

import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';
import '../../../discussion/presentation/screens/discussion_screen.dart';
import '../../domain/entities/course_conduct_data_entity.dart';
import '../screens/course_topic_screen.dart';
import '../screens/details_screen.dart';
import '../../domain/entities/course_overview_data_entity.dart';
import '../screens/course_subject_screen.dart';
import '../../../faq/presentation/screens/faq_screen.dart';

class CourseTabSectionWidget extends StatefulWidget {
  final String? tabTitle1, tabTitle2, tabTitle3, tabTitle4;
  final CourseConductDataEntity? courseConductDataEntity;
  const CourseTabSectionWidget({
    super.key,
    this.tabTitle1,
    this.tabTitle2,
    this.tabTitle3,
    this.tabTitle4,
    this.courseConductDataEntity
  });

  @override
  State<CourseTabSectionWidget> createState() => _CourseTabSectionWidgetState();
}

class _CourseTabSectionWidgetState extends State<CourseTabSectionWidget>
    with AppTheme, Language, TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar.secondary(
            controller: _tabController,
            isScrollable: false,
            padding: EdgeInsets.zero, // Minimize horizontal padding
            indicatorPadding: EdgeInsets.zero, // Remove or reduce indicator padding
            // tabAlignment: TabAlignment.start, // Remove or reduce indicator padding

            labelStyle: TextStyle(
                color: clr.blackColor,
                fontSize: size.textSmall,
                fontWeight: FontWeight.w600,
                fontFamily: StringData.fontFamilyPoppins),
            unselectedLabelStyle: TextStyle(
                color: clr.textColorBlack,
                fontSize: size.textSmall,
                fontWeight: FontWeight.w500,
                fontFamily: StringData.fontFamilyPoppins),
            dividerColor: clr.placeHolderTextColorGray,
            tabs: [
              Tab(
                  text:
                      widget.tabTitle1 ?? label(e: en.details, b: bn.details)),
              Tab(
                  text: widget.tabTitle2 ??
                      label(e: en.notesText, b: bn.notesText)),
              Tab(
                  text: widget.tabTitle3 ??
                      label(e: en.discussion, b: bn.discussion)),
              Tab(
                  text: widget.tabTitle4 ??
                      label(e: en.discussion, b: bn.discussion)),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                CourseTopicScreen(data: widget.courseConductDataEntity!),
                CourseTopicScreen(data: widget.courseConductDataEntity!),
                CourseTopicScreen(data: widget.courseConductDataEntity!),
                CourseTopicScreen(data: widget.courseConductDataEntity!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
