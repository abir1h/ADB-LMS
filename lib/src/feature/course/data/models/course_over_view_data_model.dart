import 'package:adb_mobile/src/feature/course/data/models/material_data_model.dart';
import 'package:adb_mobile/src/feature/course/data/models/topic_data_model.dart';
import 'package:flutter/cupertino.dart';
@immutable
class CourseOverViewDataModel {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final int expiryMonth;
  final int noOfRating;
  final double rating;
  final String code;
  final List<TopicDataModel> topics;
  final bool bookmarked;
  final int progress;
  final bool enrollment;
  final bool isManager;
  final bool certificateAchieved;
  final bool courseTestCompleted;

  const CourseOverViewDataModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.expiryMonth,
    required this.noOfRating,
    required this.rating,
    required this.code,
    required this.topics,
    required this.bookmarked,
    required this.progress,
    required this.enrollment,
    required this.isManager,
    required this.certificateAchieved,
    required this.courseTestCompleted,
  });

  factory CourseOverViewDataModel.fromJson(Map<String, dynamic> json) =>
      CourseOverViewDataModel(
        id: json["Id"] ?? "",
        title: json["Title"] ?? "",
        description: json["Description"] ?? "",
        imagePath: json["ImagePath"] ?? "",
        expiryMonth: json["ExpiryMonth"] ?? -1,
        noOfRating: json["NoOfRating"] ?? -1,
        rating: json["Rating"] ?? 0.0.toDouble(),
        code: json["Code"] ?? "",
        topics: json["Topics"] != null
            ? List<TopicDataModel>.from(
                (json["Topics"]).map((x) => TopicDataModel.fromJson(x)))
            : [],
        bookmarked: json["Bookmarked"] ?? false,
        progress: json["Progress"] ?? -1,
        enrollment: json["Enrollment"] ?? false,
        isManager: json["IsManager"] ?? false,
        certificateAchieved: json["CertificateAchieved"] ?? false,
        courseTestCompleted: json["CourseTestCompleted"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Title": title,
        "Description": description,
        "ImagePath": imagePath,
        "ExpiryMonth": expiryMonth,
        "NoOfRating": noOfRating,
        "Rating": rating,
        "Code": code,
        "Topics": List<dynamic>.from(topics.map((x) => x.toJson())),
        "Bookmarked": bookmarked,
        "Progress": progress,
        "Enrollment": enrollment,
        "IsManager": isManager,
        "CertificateAchieved": certificateAchieved,
        "CourseTestCompleted": courseTestCompleted,
      };
}
