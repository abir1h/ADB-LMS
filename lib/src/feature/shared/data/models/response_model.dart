import 'package:flutter/foundation.dart';

@immutable
class ResponseModel<T> {
  final String message;
  final String? error;
  final int? status;
  final T? data;

  const ResponseModel({
    required this.message,
    this.error,
    this.status,
    this.data,
  });

  factory ResponseModel.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return ResponseModel<T>(
      message: json["Message"] ?? "",
      error: json["Error"],
      status: json["Status"],
      data: json["Data"] == null ? null : fromJsonT(json["Data"]),
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) => {
        "Message": message,
        "Error": error,
        "Status": status,
        "Data": data == null ? null : toJsonT(data as T),
      };
}
