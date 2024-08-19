import 'package:adb_mobile/src/feature/authentication/data/models/institute_data_model.dart';

class InstituteListDataModel {
  final List<InstituteDataModel> data;
  final String message;
  final int status;

  InstituteListDataModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory InstituteListDataModel.fromJson(Map<String, dynamic> json) => InstituteListDataModel(
    data: json["Data"] != null
        ? List<InstituteDataModel>.from(
        (json["Data"]).map((x) => InstituteDataModel.fromJson(x)))
        : [],
    message: json["Message"]??"",
    status: json["Status"]??-1,
  );

  Map<String, dynamic> toJson() => {
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
    "Message": message,
    "Status": status,
  };
}