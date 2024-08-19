import 'package:flutter/cupertino.dart';

@immutable
class NotificationItemDataModel {
  final String id;
  final String title;
  final String details;
  final String createdOn;
  final String creatorName;
  final String creatorEmail;
  final String creatorPhoneNumber;
  final String notificationType;
  final String payload;
  final String navigateTo;
  final bool seen;

  const NotificationItemDataModel({
    required this.id,
    required this.title,
    required this.details,
    required this.createdOn,
    required this.creatorName,
    required this.creatorEmail,
    required this.creatorPhoneNumber,
    required this.notificationType,
    required this.payload,
    required this.navigateTo,
    required this.seen,
  });

  factory NotificationItemDataModel.fromJson(Map<String, dynamic> json) => NotificationItemDataModel(
    id: json["Id"]??"",
    title: json["Title"]??"",
    details: json["Details"]??"",
    createdOn: json["CreatedOn"]??"",
    creatorName: json["CreatorName"]??"",
    creatorEmail: json["CreatorEmail"]??"",
    creatorPhoneNumber: json["CreatorPhoneNumber"]??"",
    notificationType: json["NotificationType"]??"",
    payload: json["Payload"]??"",
    navigateTo: json["NavigateTo"]??"",
    seen: json["Seen"]??false,
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Title": title,
    "Details": details,
    "CreatedOn": createdOn,
    "CreatorName": creatorName,
    "CreatorEmail": creatorEmail,
    "CreatorPhoneNumber": creatorPhoneNumber,
    "NotificationType": notificationType,
    "Payload": payload,
    "NavigateTo": navigateTo,
    "Seen": seen,
  };
}
