import 'package:adb_mobile/src/feature/profile/data/models/result_data_model.dart';
import 'package:flutter/cupertino.dart';
@immutable
class TraineeUserDataModel {
  final int id;
  final String exception;
  final int status;
  final bool isCanceled;
  final bool isCompleted;
  final bool isCompletedSuccessfully;
  final int creationOptions;
  final String asyncState;
  final bool isFaulted;
  final ResultDataModel? result;

  const TraineeUserDataModel({
    required this.result,
    required this.id,
    required this.exception,
    required this.status,
    required this.isCanceled,
    required this.isCompleted,
    required this.isCompletedSuccessfully,
    required this.creationOptions,
    required this.asyncState,
    required this.isFaulted,
  });

  factory TraineeUserDataModel.fromJson(Map<String, dynamic> json) => TraineeUserDataModel(
    id: json["Id"]??-1,
    exception: json["Exception"]??"",
    status: json["Status"]??-1,
    isCanceled: json["IsCanceled"]??false,
    isCompleted: json["IsCompleted"]??false,
    isCompletedSuccessfully: json["IsCompletedSuccessfully"]??false,
    creationOptions: json["CreationOptions"]??-1,
    asyncState: json["AsyncState"]??"",
    isFaulted: json["IsFaulted"]??false,
    result: json['Result'] != null
        ? ResultDataModel.fromJson(json['Result'])
        : null,

  );

  Map<String, dynamic> toJson() => {
    "Result": result?.toJson(),
    "Id": id,
    "Exception": exception,
    "Status": status,
    "IsCanceled": isCanceled,
    "IsCompleted": isCompleted,
    "IsCompletedSuccessfully": isCompletedSuccessfully,
    "CreationOptions": creationOptions,
    "AsyncState": asyncState,
    "IsFaulted": isFaulted,
  };
}
