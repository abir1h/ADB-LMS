import 'package:adb_mobile/src/feature/certificate/data/models/Certificate_data_model.dart';
import 'package:flutter/cupertino.dart';


@immutable
class CertificateListDataModel {
  final List<CertificateDataModel> data;
  final int total;

  const CertificateListDataModel({
    required this.data,
    required this.total,
  });

  factory CertificateListDataModel.fromJson(Map<String, dynamic> json) =>
      CertificateListDataModel(
        data: json["Records"] != null
            ? List<CertificateDataModel>.from(
                (json["Records"]).map((x) => CertificateDataModel.fromJson(x)))
            : [],
        total: json["Total"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
        "total": total,
      };
}
