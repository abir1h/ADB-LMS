import 'package:flutter/cupertino.dart';

import 'course_info_data_model.dart';
@immutable
class DashboardCourseListDataModel {
  final List<CourseInfoDataModel> data;
  final String key;

  const DashboardCourseListDataModel({
    required this.data,
    required this.key,
  });

  factory DashboardCourseListDataModel.fromJson(Map<String, dynamic> json) =>
      DashboardCourseListDataModel(
        data: json["Data"] != null
            ? List<CourseInfoDataModel>.from(
                (json["Data"]).map((x) => CourseInfoDataModel.fromJson(x)))
            : [],
        key: json["Key"],
      );

  Map<String, dynamic> toJson() => {
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
        "Key": key,
      };
}
