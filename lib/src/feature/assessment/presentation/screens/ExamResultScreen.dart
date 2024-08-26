import 'package:adb_mobile/src/feature/assessment/domain/entities/exam_result_data_entity.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/utility/app_label.dart';
import '../../../course/presentation/screens/course_conduct_faq_screen.dart';
import '../../domain/entities/exam_info_data_entity.dart';
import '../services/exam_result_screen_service.dart';
import '../widgets/custom_text_widget.dart';
import '../../domain/entities/mcq_data_entity.dart';
import '../services/exam_info_details_screen_service.dart';

class ExamResultScreen extends StatefulWidget {
  final ExamInfoDataEntity data;
  final String examType;
  const ExamResultScreen(
      {super.key, required this.data, required this.examType});

  @override
  State<ExamResultScreen> createState() => _ExamResultScreenState();
}

class _ExamResultScreenState extends State<ExamResultScreen>
    with AppTheme, ExamResultScreenService {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadExamResult(widget.data.id);
    });
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:             AppStreamBuilder<List<ExamResultDataEntity>>(
        stream: resultListStreamController.stream,
        loadingBuilder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        dataBuilder: (context, data) {
          return ExamResultSectionWidget(
              items: data,
              buildItem: (BuildContext context, int index, item) {
                return ExamResultItemWidget(
                  data: item,
                  onTap: () {},
                );
              });
        },
        emptyBuilder: (context, message, icon) => Padding(
            padding: EdgeInsets.all(size.h24),
            child: Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Lottie.asset(ImageAssets.emptyAnimation, height: size.h64 * 3),
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
      ),

    );
  }

  @override
  void onTapExamDetailsScreen(List<McqDataEntity> data) {
    Navigator.pushNamed(context, AppRoute.examViewScreen,
        arguments:
        ExamScreenArgs(examInfoDataEntity: widget.data, examData: data));
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
          Icons.arrow_forward,
          size: size.r16,
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

class ExamResultSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;
  const ExamResultSectionWidget(
      {Key? key, required this.items, required this.buildItem})
      : super(key: key);

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
        return SizedBox(height: size.h10,);
      },
    );
  }
}

class ExamResultItemWidget<T> extends StatelessWidget with AppTheme {
  final ExamResultDataEntity data;
  final VoidCallback onTap;
  const ExamResultItemWidget({super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ExpansionTile(
          title: Text(
            data.testType.toString(),
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: size.textSmall,
                color: clr.headerColor),
          ),
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(size.w12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.gainedMarks.toString(),
                    style: TextStyle(
                        fontSize: size.textXSmall,
                        color: clr.textGrey,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}