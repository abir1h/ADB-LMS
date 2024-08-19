import 'package:flutter/cupertino.dart';

@immutable
class InstituteDataModel {
  final String id;
  final String name;

  const InstituteDataModel({
    required this.id,
    required this.name,
  });

  factory InstituteDataModel.fromJson(Map<String, dynamic> json) =>
      InstituteDataModel(
        id: json["Id"] ?? "",
        name: json["Name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
      };
  static List<InstituteDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, InstituteDataModel>(
            json.map((x) => InstituteDataModel.fromJson(x)).toList())
        : [];
  }
}
