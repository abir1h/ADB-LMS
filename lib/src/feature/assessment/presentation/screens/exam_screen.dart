import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/circular_loader_widget.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/custom_dialog_widget.dart';
import '../../../../core/common_widgets/custom_scaffold.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/utility/app_label.dart';
import '../../domain/entities/exam_result_data_entity.dart';
import '../services/exam_screen_service.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/app_theme.dart';
import '../widgets/mcq_answer_widget.dart';
import '../widgets/question_widget.dart';
import '../widgets/result_dialog.dart';
import '../widgets/time_digit_widget.dart';

class ExamScreen extends StatefulWidget {
  final Object? arguments;
  const ExamScreen({super.key, this.arguments})
      : assert(arguments != null && arguments is ExamScreenArgs);

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen>
    with AppTheme, ExamScreenService {
  @override
  void initState() {
    super.initState();
    screenArgs = widget.arguments as ExamScreenArgs;
    initService(screenArgs);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "পরীক্ষা",
      resizeToAvoidBottomInset: true,
      leadingBack: onGoBack,
      actionChild: TimeDigitWidget(
        examStateStream: pageStateStreamController.stream,
        timerStream: timerStreamController.stream,
        isExamRunning: (x) => x != null && (x is DataLoadedState),
      ),
      body: AppStreamBuilder<PageState>(
        stream: pageStateStreamController.stream,
        loadingBuilder: (context) => const Center(child: CircularLoader()),
        emptyBuilder: (context, message, icon) => const Offstage(),
        dataBuilder: (context, data) {
          if (data is ExamRunningState) {
            return SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: size.h12),
                  Container(
                    color: clr.whiteColor,
                    child: Center(
                      child: StreamBuilder<String>(
                        initialData:
                            "প্রশ্ন: ${"${replaceEnglishNumberWithBengali("1")}/${replaceEnglishNumberWithBengali(data.examData.length.toString())}"}",
                        stream: questionNumberTextStream.stream,
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.data!,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: PageView.builder(
                        controller: questionPagerController,
                        itemCount: data.examData.length,
                        onPageChanged: onQuestionChanged,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, position) {
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                QuestionWidget(
                                    questionNo: "${position + 1}",
                                    questionText: data.examData
                                        .elementAt(position)
                                        .question,
                                    child: ListView(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: [
                                        MCQAnswerOptionWidget(
                                            value: data.examData
                                                .elementAt(position)
                                                .option1,
                                            imageValue: "",
                                            isSelected: data.examData
                                                .elementAt(position)
                                                .isOption1Selected,
                                            onTap: () {
                                              setState(() {
                                                data.examData
                                                        .elementAt(position)
                                                        .isOption1Selected =
                                                    !data.examData
                                                        .elementAt(position)
                                                        .isOption1Selected;
                                              });
                                            }),
                                        SizedBox(height: size.h12),
                                        MCQAnswerOptionWidget(
                                            value: data.examData
                                                .elementAt(position)
                                                .option2,
                                            imageValue: "",
                                            isSelected: data.examData
                                                .elementAt(position)
                                                .isOption2Selected,
                                            onTap: () {
                                              setState(() {
                                                data.examData
                                                        .elementAt(position)
                                                        .isOption2Selected =
                                                    !data.examData
                                                        .elementAt(position)
                                                        .isOption2Selected;
                                              });
                                            }),
                                        SizedBox(height: size.h12),
                                        MCQAnswerOptionWidget(
                                            value: data.examData
                                                .elementAt(position)
                                                .option3,
                                            imageValue: "",
                                            isSelected: data.examData
                                                .elementAt(position)
                                                .isOption3Selected,
                                            onTap: () {
                                              setState(() {
                                                data.examData
                                                        .elementAt(position)
                                                        .isOption3Selected =
                                                    !data.examData
                                                        .elementAt(position)
                                                        .isOption3Selected;
                                              });
                                            }),
                                        SizedBox(height: size.h12),
                                        MCQAnswerOptionWidget(
                                            value: data.examData
                                                .elementAt(position)
                                                .option4,
                                            imageValue: "",
                                            isSelected: data.examData
                                                .elementAt(position)
                                                .isOption4Selected,
                                            onTap: () {
                                              setState(() {
                                                data.examData
                                                        .elementAt(position)
                                                        .isOption4Selected =
                                                    !data.examData
                                                        .elementAt(position)
                                                        .isOption4Selected;
                                              });
                                            }),
                                      ],
                                    ))
                              ],
                            ),
                          );
                        }, // Can be null
                      ),
                    ),
                  ),
                  StreamBuilder<Map<String, dynamic>>(
                    initialData: const {
                      "next": "পরবর্তী",
                      "previous": false,
                    },
                    stream: buttonTextStream.stream,
                    builder: (context, snapshot) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.w16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            snapshot.data!["previous"] != false
                                ? CustomButton(
                                    onTap: () {
                                      onPreviousButtonTap();
                                    },
                                    title:
                                        label(e: "Previous", b: "পূর্ববর্তী"))
                                : const Offstage(),
                            CustomButton(
                                onTap: () => onNextTap(),
                                title: snapshot.data!["next"])
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: size.h6),
                  SizedBox(
                      height: size.h48,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          StreamBuilder<int>(
                            initialData: 0,
                            stream: pageSelectedIndexStream.stream,
                            builder: (context, snapshot) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: data.examData.length,
                                  controller: scrollController,
                                  scrollDirection: Axis.horizontal,
                                  physics: const ClampingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        questionPagerController.animateToPage(
                                            index,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.ease);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.h12),
                                        alignment: Alignment.center,
                                        child: snapshot.data != index
                                            ? Text(
                                                label(
                                                    e: "${index + 1}",
                                                    b: replaceEnglishNumberWithBengali(
                                                        "${index + 1}")),
                                                style: TextStyle(
                                                    color:
                                                        clr.textColorAppleBlack,
                                                    fontSize: size.textMedium,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            : Container(
                                                decoration: BoxDecoration(
                                                    color:
                                                        clr.appPrimaryColorBlue,
                                                    shape: BoxShape.circle),
                                                padding:
                                                    EdgeInsets.all(size.h12),
                                                child: Text(
                                                  label(
                                                      e: "${index + 1}",
                                                      b: replaceEnglishNumberWithBengali(
                                                          "${index + 1}")),
                                                  style: TextStyle(
                                                      color: clr.whiteColor,
                                                      fontSize: size.textMedium,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                      ),
                                    );
                                  });
                            },
                          ),
                          StreamBuilder<Map<String, dynamic>>(
                            initialData: const {
                              "next": true,
                              "previous": false,
                            },
                            stream: pageArrowButtonStream.stream,
                            builder: (context, snapshot) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  snapshot.data!["previous"] != false
                                      ? GestureDetector(
                                          onTap: () {
                                            scrollController.animateTo(
                                                scrollController
                                                        .position.pixels -
                                                    150,
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                curve: Curves.easeIn);
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: clr.whiteColor),
                                              child: const Icon(
                                                  Icons.arrow_back_ios_new)),
                                        )
                                      : const Offstage(),
                                  const Spacer(),
                                  snapshot.data!["next"] != false
                                      ? GestureDetector(
                                          onTap: () {
                                            scrollController.animateTo(
                                                scrollController
                                                        .position.pixels +
                                                    150,
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                curve: Curves.easeIn);
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: clr.whiteColor),
                                              child: const Icon(
                                                  Icons.arrow_forward_ios)),
                                        )
                                      : const Offstage(),
                                ],
                              );
                            },
                          ),
                        ],
                      )),
                  SizedBox(height: size.h24),
                ],
              ),
            );
          } else if (data is TimeExpiredState) {
            ////TODO: Later
            return Container();
            // return TimeExpiredPanelWidget(
            //   examDataEntity: data.examData,
            //   doSubmitResult: (v) => onSubmitExam(v),
            // );
          } else {
            return const Offstage();
          }
        },
      ),
    );
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }

  @override
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
  }

  @override
  void showExamSubmitDialog(ExamResultDataEntity examResultDataEntity) {
    // CustomDialogWidget.show(
    //         context: context,
    //         icon: Icons.quiz_outlined,
    //         title: "উত্তরপত্র সফলভাবে জমা দেওয়া হয়েছে",
    //         infoText: "",
    //         singleButtonText: "বন্ধ করুন",
    //         singleButton: true)
    //     .then((value) {
    //   if (value) {
    //     ///Force close
    //     forceClose();
    //   }
    // });
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return ResultDialog(examResultDataEntity: examResultDataEntity,);
        }).then((value) {
      if (value) {
        ///Force close
        forceClose();
      }
    });
  }

  @override
  void showExamCancellationDialog() {
    CustomDialogWidget.show(
      context: context,
      title: "আপনি কি নিশ্চিত?",
      infoText: "আপনি পরীক্ষা বাতিল করতে চান? আপনার উত্তরগুলি জমা দেওয়া হবে না৷\n",
      leftButtonText: "বাতিল করুন",
      rightButtonText: "প্রস্থান করুন"
    ).then((value) {
      if (value) {
        ///Force close
        forceClose();
      }
    });
  }

  @override
  void forceClose() {
    Navigator.of(context).pop();
  }

}
