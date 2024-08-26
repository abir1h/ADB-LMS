import 'package:adb_mobile/src/feature/assessment/presentation/screens/ExamResultScreen.dart';
import 'package:flutter/material.dart';

import '../screens/exam_info_details_screen.dart';
import '../../domain/entities/exam_info_data_entity.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/utility/app_label.dart';

class ExamTabSectionWidget extends StatefulWidget {
  final String? tabTitle1, tabTitle2;
  final ExamInfoDataEntity? examInfoDataEntity;
  final String? examType;
  const ExamTabSectionWidget({
    super.key,
    this.tabTitle1,
    this.tabTitle2,
    this.examInfoDataEntity,
    this.examType
  });

  @override
  State<ExamTabSectionWidget> createState() => _ExamTabSectionWidgetState();
}

class _ExamTabSectionWidgetState extends State<ExamTabSectionWidget>
    with AppTheme, Language, TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
            controller: _tabController, isScrollable: true,
            padding: EdgeInsets.zero, // Minimize horizontal padding
            indicatorPadding:
                EdgeInsets.zero, // Remove or reduce indicator padding
            tabAlignment:
                TabAlignment.start, // Remove or reduce indicator padding

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
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                //Info Details
                ExamInfoDetailsScreen(data: widget.examInfoDataEntity!, examType: widget.examType!),
                //Result list Screen
                ExamResultScreen(data: widget.examInfoDataEntity!, examType: widget.examType!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
