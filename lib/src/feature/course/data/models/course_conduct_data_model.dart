import 'package:adb_mobile/src/feature/course/data/models/course_model.dart';
import 'package:adb_mobile/src/feature/course/data/models/material_model.dart';
import 'package:adb_mobile/src/feature/course/data/models/topic_model.dart';
import 'package:flutter/cupertino.dart';

@immutable
class CourseConductDataModel {
  final CourseModel? course;
  final TopicModel? topic;
  final int progress;
  final List<MaterialModel>? materials;

  const CourseConductDataModel({
    required this.course,
    required this.topic,
    required this.progress,
    required this.materials,
  });

  factory CourseConductDataModel.fromJson(Map<String, dynamic> json) => CourseConductDataModel(
    course:  json['Course'] != null
        ? CourseModel.fromJson(json["Course"])
        : null,
    topic:  json['Topic'] != null
        ? TopicModel.fromJson(json["Topic"])
        : null,
    progress: json["Progress"]??-1,
    materials: json["Materials"] != null
        ? List<MaterialModel>.from(
        (json["Materials"]).map((x) => MaterialModel.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "Course": course!.toJson(),
    "Topic": topic!.toJson(),
    "Progress": progress,
    "Materials": List<dynamic>.from(materials!.map((x) => x.toJson())),
  };
}



