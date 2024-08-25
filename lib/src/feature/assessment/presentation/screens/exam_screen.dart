import 'package:flutter/material.dart';

import '../../../../core/routes/app_route_args.dart';
import '../services/exam_screen_service.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/app_theme.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadQuestions(screenArgs.materialId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Text("Test");
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }
}
