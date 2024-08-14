import 'package:flutter/cupertino.dart';

@immutable
class CertificateDataModel {
  final String courseId;
  final String date;
  final String title;
  final bool certificateAchieved;

  const CertificateDataModel({
    required this.courseId,
    required this.date,
    required this.title,
    required this.certificateAchieved,
  });

  factory CertificateDataModel.fromJson(Map<String, dynamic> json) =>
      CertificateDataModel(
        courseId: json["CourseId"] ?? "",
        date: json["Date"] ?? "",
        title: json["Title"] ?? "",
        certificateAchieved: json["CertificateAchieved"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "CourseId": courseId,
        "Date": date,
        "Title": title,
        "CertificateAchieved": certificateAchieved,
      };
  static List<CertificateDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, CertificateDataModel>(
            json.map((x) => CertificateDataModel.fromJson(x)).toList())
        : [];
  }
}
