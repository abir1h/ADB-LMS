import 'package:flutter/cupertino.dart';

@immutable
class ResourceDataModel {
  final String materialId;
  final String title;
  final String filePath;
  final double fileSizekb;

  const ResourceDataModel({
    required this.materialId,
    required this.title,
    required this.filePath,
    required this.fileSizekb,
  });

  factory ResourceDataModel.fromJson(Map<String, dynamic> json) => ResourceDataModel(
    materialId: json["MaterialId"]??"",
    title: json["Title"]??"",
    filePath: json["FilePath"]??"",
    fileSizekb: json["FileSizekb"]??"",
  );

  Map<String, dynamic> toJson() => {
    "MaterialId": materialId,
    "Title": title,
    "FilePath": filePath,
    "FileSizekb": fileSizekb,
  };
}