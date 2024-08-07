import 'package:flutter/foundation.dart';

@immutable
class ResponseModel<T> {
  final String message;
  final String? error;
  final T? data;

  const ResponseModel({
    required this.message,
    this.error,
    this.data,
  });

  factory ResponseModel.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return ResponseModel<T>(
      message: json["message"] ?? "",
      error: json["error"],
      data: json["data"] == null ? null : fromJsonT(json["data"]),
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) => {
        "message": message,
        "error": error,
        "data": data == null ? null : toJsonT(data as T),
      };
}
