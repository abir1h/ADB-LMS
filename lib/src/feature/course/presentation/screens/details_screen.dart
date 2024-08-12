import 'package:flutter/cupertino.dart';

import '../../../../core/constants/app_theme.dart';
import '../../domain/entities/course_overview_data_entity.dart';

class DetailsScreen extends StatefulWidget {
  final CourseOverViewDataEntity data;
  const DetailsScreen({super.key, required this.data});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with AppTheme {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: size.h12, horizontal: size.w12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.data.title,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: size.textLarge,
                color: clr.appPrimaryColorBlue),
          ),
          Text(
            widget.data.description,
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