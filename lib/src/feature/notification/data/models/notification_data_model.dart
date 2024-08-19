import 'package:adb_mobile/src/feature/notification/data/models/notification_item_data_model.dart';
import 'package:flutter/cupertino.dart';

@immutable
class NotificationDataModel {
  final List<NotificationItemDataModel> records;
  final int total;
  final int unseenTotal;

  const NotificationDataModel({
    required this.records,
    required this.total,
    required this.unseenTotal,
  });

  factory NotificationDataModel.fromJson(Map<String, dynamic> json) =>
      NotificationDataModel(
        records: json["Records"] != null
            ? List<NotificationItemDataModel>.from((json["Records"])
                .map((x) => NotificationItemDataModel.fromJson(x)))
            : [],
        total: json["Total"] ?? -1,
        unseenTotal: json["UnseenTotal"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "Records": List<dynamic>.from(records.map((x) => x.toJson())),
        "Total": total,
        "UnseenTotal": unseenTotal,
      };
}
