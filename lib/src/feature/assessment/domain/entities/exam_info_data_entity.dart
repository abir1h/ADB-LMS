class ExamInfoDataEntity {
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

  ExamInfoDataEntity({
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
}
