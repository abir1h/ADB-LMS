
import 'package:flutter/cupertino.dart';

import '../../../dashboard/data/models/course_info_data_model.dart';
@immutable
class CourseListDataModel {
  final List<CourseInfoDataModel> data;
  final int total;

  const CourseListDataModel({
    required this.data,
    required this.total,
  });

  factory CourseListDataModel.fromJson(Map<String, dynamic> json) =>
      CourseListDataModel(
        data: json["Records"] != null
            ? List<CourseInfoDataModel>.from(
            (json["Records"]).map((x) => CourseInfoDataModel.fromJson(x)))
            : [],
        total: json["Total"]??-1,
      );

  Map<String, dynamic> toJson() => {
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
    "total": total,
  };
}
