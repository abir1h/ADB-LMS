import 'package:flutter/cupertino.dart';

@immutable
class FaqDataModel {
  final String id;
  final String question;
  final String answer;

  const FaqDataModel({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory FaqDataModel.fromJson(Map<String, dynamic> json) => FaqDataModel(
        id: json["Id"] ?? "",
        question: json["Question"] ?? "",
        answer: json["Answer"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Question": question,
        "Answer": answer,
      };
  static List<FaqDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, FaqDataModel>(
            json.map((x) => FaqDataModel.fromJson(x)).toList())
        : [];
  }
}
