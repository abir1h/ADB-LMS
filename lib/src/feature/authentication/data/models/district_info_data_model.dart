import 'package:flutter/cupertino.dart';

@immutable
class DistrictInfoDataModel {
  final String id;
  final String name;

  const DistrictInfoDataModel({
    required this.id,
    required this.name,
  });

  factory DistrictInfoDataModel.fromJson(Map<String, dynamic> json) =>
      DistrictInfoDataModel(
        id: json["Id"] ?? "",
        name: json["Name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
      };

  static List<DistrictInfoDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, DistrictInfoDataModel>(
        json.map((x) => DistrictInfoDataModel.fromJson(x)).toList())
        : [];
  }
}
