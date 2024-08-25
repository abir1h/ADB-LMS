import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../domain/entities/exam_info_data_entity.dart';
import '../services/exam_info_screen_service.dart';
import '../widgets/exam_tab_section_widget.dart';

class ExamInfoScreen extends StatefulWidget {
  final Object? arguments;
  const ExamInfoScreen({super.key, this.arguments})
      : assert(arguments != null && arguments is ExamInfoScreenArgs);
  @override
  State<ExamInfoScreen> createState() => _ExamInfoScreenState();
}

class _ExamInfoScreenState extends State<ExamInfoScreen>
    with AppTheme, ExamInfoScreenService {


  @override
  void initState() {
    super.initState();
    screenArgs = widget.arguments as ExamInfoScreenArgs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadExamInfoDetails(screenArgs.materialId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clr.scaffoldBackgroundColor,
      appBar: AppBar(
        leadingWidth: size.w40,
        title: Text(
          "পরীক্ষা",
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
        return AppStreamBuilder<ExamInfoDataEntity>(
          stream: examInfoStreamController.stream,
          loadingBuilder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          dataBuilder: (context, data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.h10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.h16),
                  child: Text(
                    data.topicTitle,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: clr.blackColor,
                        fontSize: size.textLarge),
                  ),
                ),
                SizedBox(height: size.h16),
                ExamTabSectionWidget(
                  tabTitle1: "প্রি-পোস্ট টেস্ট",
                  tabTitle2: "ফলাফল",
                  examInfoDataEntity: data,
                  examType: screenArgs.examType,
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
    CustomToasty.of(context).showWarning(message);
  }

}
