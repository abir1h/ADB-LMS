import 'package:adb_mobile/src/feature/course/data/models/popup_quiz_data_model.dart';
import 'package:adb_mobile/src/feature/course/data/models/resource_data_model.dart';
import 'package:flutter/cupertino.dart';

@immutable
class MaterialModel {
  final String id;
  final String title;
  final String type;
  final String filePath;
  final String s3Path;
  final String externalLink;
  final String youtubeId;
  final int fileSizeKb;
  final int videoDurationSecond;
  final int sequence;
  final bool studied;
  final bool restricted;
  final String lastStudyTimeSec;
  final int requiredStudyTimeSec;
  final bool canDownload;
  final List<ResourceDataModel> resources;
  final List<PopupQuizDataModel> popupQuizzes;
  final bool isCompleted;
  final int progress;

  const MaterialModel({
    required this.id,
    required this.title,
    required this.type,
    required this.filePath,
    required this.s3Path,
    required this.externalLink,
    required this.youtubeId,
    required this.fileSizeKb,
    required this.videoDurationSecond,
    required this.sequence,
    required this.studied,
    required this.restricted,
    required this.lastStudyTimeSec,
    required this.requiredStudyTimeSec,
    required this.canDownload,
    required this.resources,
    required this.popupQuizzes,
    required this.isCompleted,
    required this.progress,
  });

  factory MaterialModel.fromJson(Map<String, dynamic> json) => MaterialModel(
        id: json["Id"] ?? "",
        title: json["Title"] ?? "",
        type: json["Type"] ?? "",
        filePath: json["FilePath"] ?? "",
        s3Path: json["S3Path"] ?? "",
        externalLink: json["ExternalLink"] ?? "",
        youtubeId: json["YoutubeID"] ?? "",
        fileSizeKb: json["FileSizeKb"] ?? -1,
        videoDurationSecond: json["VideoDurationSecond"] ?? -1,
        sequence: json["Sequence"] ?? -1,
        studied: json["Studied"] ?? false,
        restricted: json["Restricted"] ?? false,
        lastStudyTimeSec: json["LastStudyTimeSec"] ?? "",
        requiredStudyTimeSec: json["RequiredStudyTimeSec"] ?? -1,
        canDownload: json["CanDownload"] ?? false,
        resources: json["Resources"] != null
            ? List<ResourceDataModel>.from(
                (json["Resources"]).map((x) => ResourceDataModel.fromJson(x)))
            : [],
        popupQuizzes: json["PopupQuizzes"] != null
            ? List<PopupQuizDataModel>.from((json["PopupQuizzes"])
                .map((x) => PopupQuizDataModel.fromJson(x)))
            : [],
        isCompleted: json["IsCompleted"] ?? false,
        progress: json["Progress"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Title": title,
        "Type": type,
        "FilePath": filePath,
        "S3Path": s3Path,
        "ExternalLink": externalLink,
        "YoutubeID": youtubeId,
        "FileSizeKb": fileSizeKb,
        "VideoDurationSecond": videoDurationSecond,
        "Sequence": sequence,
        "Studied": studied,
        "Restricted": restricted,
        "LastStudyTimeSec": lastStudyTimeSec,
        "RequiredStudyTimeSec": requiredStudyTimeSec,
        "CanDownload": canDownload,
        "Resources": List<dynamic>.from(resources.map((x) => x)),
        "PopupQuizzes": List<dynamic>.from(popupQuizzes.map((x) => x.toJson())),
        "IsCompleted": isCompleted,
        "Progress": progress,
      };
  static List<MaterialModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, MaterialModel>(
            json.map((x) => MaterialModel.fromJson(x)).toList())
        : [];
  }
}
