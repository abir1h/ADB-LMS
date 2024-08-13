import 'package:flutter/cupertino.dart';

@immutable
class VideoDropdownDataModel {
  final String id;
  final String title;

  const VideoDropdownDataModel({
    required this.id,
    required this.title,
  });

  factory VideoDropdownDataModel.fromJson(Map<String, dynamic> json) =>
      VideoDropdownDataModel(
        id: json["Id"],
        title: json["Title"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Title": title,
      };
  static List<VideoDropdownDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, VideoDropdownDataModel>(
            json.map((x) => VideoDropdownDataModel.fromJson(x)).toList())
        : [];
  }
}
