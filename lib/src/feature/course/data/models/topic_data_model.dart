import 'package:flutter/cupertino.dart';

import 'material_data_model.dart';

@immutable
class TopicDataModel {
  final String id;
  final String title;
  final List<MaterialDataModel> materials;
  final int progressSum;
  final int materialCount;
  final int progress;
  final bool testsCompleted;

  const TopicDataModel({
    required this.id,
    required this.title,
    required this.materials,
    required this.progressSum,
    required this.materialCount,
    required this.progress,
    required this.testsCompleted,
  });

  factory TopicDataModel.fromJson(Map<String, dynamic> json) => TopicDataModel(
    id: json["Id"]??"",
    title: json["Title"]??"",
    materials:json["Materials"] != null
        ? List<MaterialDataModel>.from(
        (json["Materials"]).map((x) => MaterialDataModel.fromJson(x)))
        : [],
    progressSum: json["ProgressSum"]??-1,
    materialCount: json["MaterialCount"]??-1,
    progress: json["Progress"]??-1,
    testsCompleted: json["TestsCompleted"]??false,
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Title": title,
    "Materials": List<dynamic>.from(materials.map((x) => x.toJson())),
    "ProgressSum": progressSum,
    "MaterialCount": materialCount,
    "Progress": progress,
    "TestsCompleted": testsCompleted,
  };
}

