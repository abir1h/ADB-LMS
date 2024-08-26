import 'package:flutter/cupertino.dart';

@immutable
class ExamResultDataModel {
  final String id;
  final int testType;
  final int quota;
  final int totalMarks;
  final double gainedMarks;
  final String startDate;
  final int noOfCorrectAnsweredQs;
  final int totalQuestions;
  final double scored;
  final bool current;
  final bool nextUnlock;

  const ExamResultDataModel(
      {required this.id,
      required this.testType,
      required this.quota,
      required this.totalMarks,
      required this.gainedMarks,
      required this.startDate,
      required this.noOfCorrectAnsweredQs,
      required this.totalQuestions,
      required this.scored,
      required this.current,
      required this.nextUnlock});

  factory ExamResultDataModel.fromJson(Map<String, dynamic> json) =>
      ExamResultDataModel(
        id: json["Id"] ?? "",
        testType: json["TestType"] ?? -1,
        quota: json["Quota"] ?? -1,
        totalMarks: json["TotalMarks"] ?? -1,
        gainedMarks: json['GainedMarks']?.toDouble() ?? 0.0,
        startDate: json["StartDate"] ?? "",
        noOfCorrectAnsweredQs: json["NoOfCorrectAnsweredQs"] ?? -1,
        totalQuestions: json["TotalQuestions"] ?? -1,
        scored: json["Scored"]?.toDouble() ?? 0.0,
        current: json["Current"] ?? false,
        nextUnlock: json["NextUnlock"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "TestType": testType,
        "Quota": quota,
        "TotalMarks": totalMarks,
        "GainedMarks": gainedMarks,
        "StartDate": startDate,
        "NoOfCorrectAnsweredQs": noOfCorrectAnsweredQs,
        "TotalQuestions": totalQuestions,
        "Scored": scored,
        "Current": current,
        "NextUnlock": nextUnlock,
      };
  static List<ExamResultDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, ExamResultDataModel>(
            json.map((x) => ExamResultDataModel.fromJson(x)).toList())
        : [];
  }
}
