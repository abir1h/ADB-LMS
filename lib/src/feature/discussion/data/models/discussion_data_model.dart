import 'package:flutter/cupertino.dart';

@immutable
class DiscussionDataModel {
  final String id;
  final String disscussionType;
  final String material;
  final String exam;
  final String mockTest;
  final String comment;
  final String commentatorType;
  final String commentTime;
  final bool isSelfComment;
  final String email;
  final String phoneNumber;
  final String imagePath;
  final String commenterName;

  const DiscussionDataModel({
    required this.id,
    required this.disscussionType,
    required this.material,
    required this.exam,
    required this.mockTest,
    required this.comment,
    required this.commentatorType,
    required this.commentTime,
    required this.isSelfComment,
    required this.email,
    required this.phoneNumber,
    required this.imagePath,
    required this.commenterName,
  });

  factory DiscussionDataModel.fromJson(Map<String, dynamic> json) => DiscussionDataModel(
    id: json["Id"]??"",
    disscussionType: json["DisscussionType"]??"",
    material: json["Material"]??"",
    exam: json["Exam"]??"",
    mockTest: json["MockTest"]??"",
    comment: json["Comment"]??"",
    commentatorType: json["CommentatorType"]??"",
    commentTime: json["CommentTime"]??"",
    isSelfComment: json["IsSelfComment"]??false,
    email: json["Email"]??"",
    phoneNumber: json["PhoneNumber"]??"",
    imagePath: json["ImagePath"]??"",
    commenterName: json["CommenterName"]??"",
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "DisscussionType": disscussionType,
    "Material": material,
    "Exam": exam,
    "MockTest": mockTest,
    "Comment": comment,
    "CommentatorType": commentatorType,
    "CommentTime": commentTime,
    "IsSelfComment": isSelfComment,
    "Email": email,
    "PhoneNumber": phoneNumber,
    "ImagePath": imagePath,
    "CommenterName": commenterName,
  };

  static List<DiscussionDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, DiscussionDataModel>(
            json.map((x) => DiscussionDataModel.fromJson(x)).toList())
        : [];
  }
}
