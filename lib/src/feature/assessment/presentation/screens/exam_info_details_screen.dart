import 'package:flutter/material.dart';

import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/utility/app_label.dart';
import '../../domain/entities/exam_info_data_entity.dart';
import '../widgets/custom_text_widget.dart';
import '../../domain/entities/mcq_data_entity.dart';
import '../services/exam_info_details_screen_service.dart';

class ExamInfoDetailsScreen extends StatefulWidget {
  final ExamInfoDataEntity data;
  final String examType;
  const ExamInfoDetailsScreen(
      {super.key, required this.data, required this.examType});

  @override
  State<ExamInfoDetailsScreen> createState() => _ExamInfoDetailsScreenState();
}

class _ExamInfoDetailsScreenState extends State<ExamInfoDetailsScreen>
    with AppTheme, ExamInfoDetailsScreenService {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h6),
        padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
        decoration: BoxDecoration(
          color: clr.shadeWhiteColor2,
          borderRadius: BorderRadius.circular(size.r8),
          border: Border.all(color: clr.cardStrokeColorGrey2, width: size.w1),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 4,
                spreadRadius: 0,
                color: clr.blackColor.withOpacity(.15))
          ],
        ),
        child: Column(children: [
          ExamInfoRowWidget(
            leftText: "পরীক্ষার নাম",
            rightText: widget.data.examName,
          ),
          SizedBox(height: size.h20),
          ExamInfoRowWidget(
            leftText: "পরীক্ষার ধরন",
            rightText: widget.examType,
          ),
          SizedBox(height: size.h20),
          ExamInfoRowWidget(
            leftText: "প্রশ্নের ধরন",
            rightText: "Mixed",
          ),
          SizedBox(height: size.h20),
          ExamInfoRowWidget(
            leftText: "মোট মার্কস",
            rightText: widget.data.marks.toString(),
          ),
          SizedBox(height: size.h20),
          ExamInfoRowWidget(
            leftText: "মোট ব্যাপ্তিকাল",
            rightText: "${widget.data.durationMnt} মিনিট",
          ),
          SizedBox(height: size.h20),
          Card(
            child: ExpansionTile(
              title: Text(
                "পরীক্ষা সংক্রান্ত নির্দেশনাবলী: (বিস্তারিত দেখতে এখানে ক্লিক করুন)",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: size.textSmall,
                    color: clr.appPrimaryColorBlue),
              ),
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(size.w12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      stringToWidget(input: widget.data.examInstructions),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.h20),
          GestureDetector(
            onTap: () => onTapStartExam(widget.data.id),
            child: Container(
              padding: EdgeInsets.all(size.w10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.r10),
                color: clr.appPrimaryColorBlue,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "পরীক্ষা শুরু করুন",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: clr.whiteColor,
                        fontSize: size.textSmall),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: size.h20),
        ]),
      ),
    );
  }

  @override
  void onTapExamDetailsScreen(List<McqDataEntity> data) {
    Navigator.pushReplacementNamed(context, AppRoute.examViewScreen,
        arguments: ExamScreenArgs(
            examInfoDataEntity: widget.data,
            examData: data,
            examType: widget.examType));
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }
}

class ExamInfoRowWidget extends StatelessWidget with AppTheme {
  final String leftText;
  final String? rightText;
  const ExamInfoRowWidget({super.key, required this.leftText, this.rightText});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: size.r8,
          color: clr.appPrimaryColorBlue,
        ),
        SizedBox(width: size.w4),
        Expanded(
          child: CustomTextWidget(
            text: leftText,
            textColor: clr.gapStrokeGrey,
            fontSize: size.textXSmall,
            fontWeight: FontWeight.w400,
          ),
        ),
        CustomTextWidget(
          text: ":",
          textColor: clr.textColorAppleBlack,
          fontWeight: FontWeight.w500,
          padding: EdgeInsets.only(left: size.w8, right: size.w24),
        ),
        if (rightText != null)
          Expanded(
            child: CustomTextWidget(
              text: rightText.toString(),
              textColor: clr.appPrimaryColorBlue,
              fontSize: size.textSmall,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
      ],
    );
  }
}
