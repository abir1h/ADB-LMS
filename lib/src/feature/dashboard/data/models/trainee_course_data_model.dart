import 'package:flutter/cupertino.dart';

@immutable
class TraineeCourseDataModel {
  final int totalLectures;
  final int totalCompltedMockTests;
  final int totalCompltedMaterials;
  final int totalCompletedLectures;

  const TraineeCourseDataModel({
    required this.totalLectures,
    required this.totalCompltedMockTests,
    required this.totalCompltedMaterials,
    required this.totalCompletedLectures,
  });

  factory TraineeCourseDataModel.fromJson(Map<String, dynamic> json) => TraineeCourseDataModel(
    totalLectures: json["TotalLectures"]??-1,
    totalCompltedMockTests: json["TotalCompltedMockTests"]??-1,
    totalCompltedMaterials: json["TotalCompltedMaterials"]??-1,
    totalCompletedLectures: json["TotalCompletedLectures"]??-1,
  );

  Map<String, dynamic> toJson() => {
    "TotalLectures": totalLectures,
    "TotalCompltedMockTests": totalCompltedMockTests,
    "TotalCompltedMaterials": totalCompltedMaterials,
    "TotalCompletedLectures": totalCompletedLectures,
  };
}
