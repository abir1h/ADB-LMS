
import 'package:flutter/cupertino.dart';

@immutable
class OtpValidationDataModel {
  final bool expireTime;
  final String otp;

  const OtpValidationDataModel({
    required this.expireTime,
    required this.otp,
  });

  factory OtpValidationDataModel.fromJson(Map<String, dynamic> json) => OtpValidationDataModel(
    expireTime: json["ExpireTime"]??false,
    otp: json["Otp"]??"",
  );

  Map<String, dynamic> toJson() => {
    "ExpireTime": expireTime,
    "Otp": otp,
  };
}