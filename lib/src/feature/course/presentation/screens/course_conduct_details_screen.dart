import 'package:adb_mobile/src/feature/course/domain/entities/course_conduct_data_entity.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/constants/app_theme.dart';

class CourseConductDetailsScreen extends StatefulWidget {
  final CourseConductDataEntity data;
  const CourseConductDetailsScreen({super.key, required this.data});

  @override
  State<CourseConductDetailsScreen> createState() => _CourseConductDetailsScreenState();
}

class _CourseConductDetailsScreenState extends State<CourseConductDetailsScreen>
    with AppTheme {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: size.h12, horizontal: size.w12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.data.course!.title,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: size.textLarge,
                color: clr.appPrimaryColorBlue),
          ),
          Text(
              widget.data.course!.description,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: size.textSmall,
                color: clr.textGrey),
          ),
        ],
      ),
    );
  }
}