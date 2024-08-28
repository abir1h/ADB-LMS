import 'package:flutter/cupertino.dart';

@immutable
class PopupQuizDataModel {
  final int timeSpan;
  final int hour;
  final int minute;
  final int second;
  final String question;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final String answers;
  final int mark;
  final String examId;
  final String exam;
  final bool updated;
  final String createdDate;
  final String createdBy;
  final String modifiedDate;
  final String modifiedBy;
  final String id;

  const PopupQuizDataModel({
    required this.timeSpan,
    required this.hour,
    required this.minute,
    required this.second,
    required this.question,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.answers,
    required this.mark,
    required this.examId,
    required this.exam,
    required this.updated,
    required this.createdDate,
    required this.createdBy,
    required this.modifiedDate,
    required this.modifiedBy,
    required this.id,
  });

  factory PopupQuizDataModel.fromJson(Map<String, dynamic> json) =>
      PopupQuizDataModel(
        timeSpan: json["TimeSpan"] ?? -1,
        hour: json["Hour"] ?? -1,
        minute: json["Minute"] ?? -1,
        second: json["Second"] ?? -1,
        question: json["Question"] ?? "",
        option1: json["Option1"] ?? "",
        option2: json["Option2"] ?? "",
        option3: json["Option3"] ?? "",
        option4: json["Option4"] ?? "",
        answers: json["Answers"] ?? "",
        mark: json["Mark"] ?? -1,
        examId: json["ExamId"] ?? "",
        exam: json["Exam"] ?? "",
        updated: json["Updated"] ?? false,
        createdDate: json["CreatedDate"] ?? "",
        createdBy: json["CreatedBy"] ?? "",
        modifiedDate: json["ModifiedDate"] ?? "",
        modifiedBy: json["ModifiedBy"] ?? "",
        id: json["Id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "TimeSpan": timeSpan,
        "Hour": hour,
        "Minute": minute,
        "Second": second,
        "Question": question,
        "Option1": option1,
        "Option2": option2,
        "Option3": option3,
        "Option4": option4,
        "Answers": answers,
        "Mark": mark,
        "ExamId": examId,
        "Exam": exam,
        "Updated": updated,
        "CreatedDate": createdDate,
        "CreatedBy": createdBy,
        "ModifiedDate": modifiedDate,
        "ModifiedBy": modifiedBy,
        "Id": id,
      };
}
