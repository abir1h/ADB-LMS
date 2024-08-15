import 'package:flutter/cupertino.dart';

@immutable
class TopicModel {
  final String courseId;
  final String course;
  final String title;
  final int sequence;
  final String materials;
  final String topicPrePostTests;
  final String createdDate;
  final String createdBy;
  final String modifiedDate;
  final String modifiedBy;
  final String id;

  const TopicModel({
    required this.courseId,
    required this.course,
    required this.title,
    required this.sequence,
    required this.materials,
    required this.topicPrePostTests,
    required this.createdDate,
    required this.createdBy,
    required this.modifiedDate,
    required this.modifiedBy,
    required this.id,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) => TopicModel(
    courseId: json["CourseId"]??"",
    course: json["Course"]??"",
    title: json["Title"]??"",
    sequence: json["Sequence"]??-1,
    materials: json["Materials"]??"",
    topicPrePostTests: json["TopicPrePostTests"]??"",
    createdDate: json["CreatedDate"]??"",
    createdBy: json["CreatedBy"]??"",
    modifiedDate: json["ModifiedDate"]??"",
    modifiedBy: json["ModifiedBy"]??"",
    id: json["Id"]??"",
  );

  Map<String, dynamic> toJson() => {
    "CourseId": courseId,
    "Course": course,
    "Title": title,
    "Sequence": sequence,
    "Materials": materials,
    "TopicPrePostTests": topicPrePostTests,
    "CreatedDate": createdDate,
    "CreatedBy": createdBy,
    "ModifiedDate": modifiedDate,
    "ModifiedBy": modifiedBy,
    "Id": id,
  };
}
