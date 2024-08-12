import 'package:adb_mobile/src/feature/dashboard/data/models/trainee_course_data_model.dart';
import 'package:flutter/cupertino.dart';
@immutable
class CourseInfoDataModel {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final String enrollmentDate;
  final TraineeCourseDataModel? traineeCourseDataModel;
  final int noOfContents;
  final int noOfContentsStudied;
  final double rating;
  final int noOfRating;
  final int progress;

  const CourseInfoDataModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.enrollmentDate,
    required this.traineeCourseDataModel,
    required this.noOfContents,
    required this.noOfContentsStudied,
    required this.rating,
    required this.noOfRating,
    required this.progress,
  });

  factory CourseInfoDataModel.fromJson(Map<String, dynamic> json) =>
      CourseInfoDataModel(
        id: json["Id"] ?? "",
        title: json["Title"] ?? "",
        description: json["Description"] ?? "",
        imagePath: json["ImagePath"] ?? "",
        enrollmentDate: json["EnrollmentDate"] ?? "",
        traineeCourseDataModel: json['TraineeCourseDataModel'] != null
            ? TraineeCourseDataModel.fromJson(json["TraineeCourseDataModel"])
            : null,
        noOfContents: json["NoOfContents"] ?? -1,
        noOfContentsStudied: json["NoOfContentsStudied"] ?? -1,
        rating: json["Rating"] ?? 0.00.toDouble(),
        noOfRating: json["NoOfRating"] ?? -1,
        progress: json["Progress"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Title": title,
        "Description": description,
        "ImagePath": imagePath,
        "EnrollmentDate": enrollmentDate,
        "TraineeCourseDataModel": traineeCourseDataModel?.toJson(),
        "NoOfContents": noOfContents,
        "NoOfContentsStudied": noOfContentsStudied,
        "Rating": rating,
        "NoOfRating": noOfRating,
        "Progress": progress,
      };
  static List<TraineeCourseDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, TraineeCourseDataModel>(
            json.map((x) => TraineeCourseDataModel.fromJson(x)).toList())
        : [];
  }
}
