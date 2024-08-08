import 'package:flutter/cupertino.dart';

@immutable
class TraineeCountDataModel {
  final int enrollments;
  final int bookmarks;
  final int certificates;
  final int examTaken;

  const TraineeCountDataModel({
    required this.enrollments,
    required this.bookmarks,
    required this.certificates,
    required this.examTaken,
  });

  factory TraineeCountDataModel.fromJson(Map<String, dynamic> json) => TraineeCountDataModel(
    enrollments: json["Enrollments"]??-1,
    bookmarks: json["Bookmarks"]??-1,
    certificates: json["Certificates"]??-1,
    examTaken: json["ExamTaken"]??-1,
  );

  Map<String, dynamic> toJson() => {
    "Enrollments": enrollments,
    "Bookmarks": bookmarks,
    "Certificates": certificates,
    "ExamTaken": examTaken,
  };
}