import 'package:adb_mobile/src/feature/course/data/models/resource_data_model.dart';
import 'package:flutter/cupertino.dart';

@immutable
class MaterialDataModel {
  final String id;
  final String title;
  final String filePath;
  final int fileType;
  final double fileSizeKb;
  final double requiredStudyTimeSec;
  final String type;
  final List<ResourceDataModel>? resources;
  final int dependencies;
  final double progress;

  const MaterialDataModel({
    required this.id,
    required this.title,
    required this.filePath,
    required this.fileType,
    required this.fileSizeKb,
    required this.requiredStudyTimeSec,
    required this.type,
    required this.resources,
    required this.dependencies,
    required this.progress,
  });

  factory MaterialDataModel.fromJson(Map<String, dynamic> json) =>
      MaterialDataModel(
        id: json["Id"] ?? "",
        title: json["Title"] ?? "",
        filePath: json["FilePath"] ?? "",
        fileType: json["FileType"] ?? -1,
        fileSizeKb: json["FileSizeKb"] ?? 0.00.toDouble(),
        requiredStudyTimeSec: json["RequiredStudyTimeSec"] ?? 0.00.toDouble(),
        type: json["Type"] ?? "",
        resources: json["Resources"] != null
            ? List<ResourceDataModel>.from(
                (json["Resources"]).map((x) => ResourceDataModel.fromJson(x)))
            : [],
        dependencies: json["Dependencies"] ?? -1,
        progress: json["Progress"] ?? 0.00.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Title": title,
        "FilePath": filePath,
        "FileType": fileType,
        "FileSizeKb": fileSizeKb,
        "RequiredStudyTimeSec": requiredStudyTimeSec,
        "Type": type,
        "Resources": List<dynamic>.from(resources!.map((x) => x.toJson())),
        "Dependencies": dependencies,
        "Progress": progress,
      };

  static List<MaterialDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, MaterialDataModel>(
            json.map((x) => MaterialDataModel.fromJson(x)).toList())
        : [];
  }
}
