class ExamInfoDataModel {
  final String id;
  final String topicId;
  final String topicTitle;
  final String examInstructions;
  final int durationMnt;
  final int marks;
  final String examName;
  final int attempt;
  final int pendingQuota;
  final bool allow;

  ExamInfoDataModel({
    required this.id,
    required this.topicId,
    required this.topicTitle,
    required this.examInstructions,
    required this.durationMnt,
    required this.marks,
    required this.examName,
    required this.attempt,
    required this.pendingQuota,
    required this.allow,
  });

  factory ExamInfoDataModel.fromJson(Map<String, dynamic> json) =>
      ExamInfoDataModel(
        id: json["Id"] ?? "",
        topicId: json["TopicId"] ?? "",
        topicTitle: json["TopicTitle"] ?? "",
        examInstructions: json["ExamInstructions"] ?? "",
        durationMnt: json["DurationMnt"] ?? -1,
        marks: json["Marks"] ?? -1,
        examName: json["ExamName"] ?? "",
        attempt: json["Attempt"] ?? -1,
        pendingQuota: json["PendingQuota"] ?? -1,
        allow: json["Allow"] ?? false,
      );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "TopicId": topicId,
    "TopicTitle": topicTitle,
    "ExamInstructions": examInstructions,
    "DurationMnt": durationMnt,
    "Marks": marks,
    "ExamName": examName,
    "Attempt": attempt,
    "PendingQuota": pendingQuota,
    "Allow": allow,
  };
}
