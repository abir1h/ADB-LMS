import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/service/notifier/app_events_notifier.dart';
import '../../domain/entities/exam_result_data_entity.dart';

class ResultDialog extends StatefulWidget {
  final ExamResultDataEntity examResultDataEntity;
  const ResultDialog({super.key, required this.examResultDataEntity});

  @override
  State<ResultDialog> createState() => _ResultDialogState();
}

class _ResultDialogState extends State<ResultDialog> with AppTheme {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              padding: EdgeInsets.only(
                left: 24.w,
                right: 24.w,
                top: 24.w,
                bottom: 24.w,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18.w),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        icon: Icon(
                          Icons.clear,
                          color: clr.blackColor,
                          size: size.r24,
                        ),
                      )
                    ],
                  ),
                  Center(
                      child: Text(
                    "পরীক্ষার ফলাফল",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: size.textLarge,
                        color: clr.appPrimaryColorBlue),
                  )),
                  SizedBox(
                    height: size.h12,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(size.r10),
                            color: clr.cardColor2),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "সঠিক উত্তর ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: size.textXXSmall,
                                    color: clr.whiteColor),
                              ),
                              Text(
                                "${widget.examResultDataEntity.noOfCorrectAnsweredQs} out of ${widget.examResultDataEntity.totalQuestions}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: size.textSmall,
                                    color: clr.whiteColor),
                              ),
                            ],
                          ),
                        ),
                      )),
                      SizedBox(
                        width: size.w20,
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(size.r10),
                            color: clr.cardColor1),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "শতকরা নম্বর ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: size.textXXSmall,
                                    color: clr.whiteColor),
                              ),
                              Text(
                                "${widget.examResultDataEntity.scored}%",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: size.textSmall,
                                    color: clr.whiteColor),
                              ),
                            ],
                          ),
                        ),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: size.h20,
                  ),
                  SizedBox(
                    height: size.h12,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "⚫️ ",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: size.textSmall,
                            color: clr.blackColor),
                      ),
                      Expanded(
                          child: Text(
                        "শতকরা ৫০% নম্বর না পেলে আপনি সার্টিফিকেট পাবেন না। অনুগ্রহপূর্বক আবার চেষ্টা করুন।",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: size.textSmall,
                            color: clr.blackColor),
                      )),
                    ],
                  ),
                  SizedBox(height: ThemeSize.instance.h32),
                  CustomButton(
                      onTap: () {
                        Navigator.of(context).pop(true);

                        if (widget.examResultDataEntity.testType == 1) {
                          AppEventsNotifier.notify(EventAction.preTest);
                        } else {
                          AppEventsNotifier.notify(EventAction.postTest);
                        }
                      },
                      title: "বন্ধ করুন"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
