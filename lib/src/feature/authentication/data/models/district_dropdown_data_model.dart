import 'package:adb_mobile/src/feature/authentication/data/models/district_info_data_model.dart';
import 'package:adb_mobile/src/feature/authentication/domain/entities/district_info_data_entity.dart';
import 'package:flutter/cupertino.dart';

@immutable
class DistrictDropDownDataModel {
  final List<DistrictInfoDataModel> data;
  final String message;
  final int status;

  const DistrictDropDownDataModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory DistrictDropDownDataModel.fromJson(Map<String, dynamic> json) =>
      DistrictDropDownDataModel(
        data: json["Data"] != null
            ? List<DistrictInfoDataModel>.from(
                (json["Data"]).map((x) => DistrictInfoDataModel.fromJson(x)))
            : [],
        message: json["Message"] ?? "",
        status: json["Status"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
        "Message": message,
        "Status": status,
      };


  static List<DistrictDropDownDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, DistrictDropDownDataModel>(
        json.map((x) => DistrictDropDownDataModel.fromJson(x)).toList())
        : [];
  }

}
