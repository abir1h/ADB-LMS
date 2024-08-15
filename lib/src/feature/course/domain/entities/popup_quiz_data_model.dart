class PopupQuizDataEntity {
  final int timeSpan;
  final int hour;
  final int minute;
  final int second;
  final String question;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final String answers;
  final int mark;
  final String examId;
  final String exam;
  final bool updated;
  final String createdDate;
  final String createdBy;
  final String modifiedDate;
  final String modifiedBy;
  final String id;

  const PopupQuizDataEntity({
    required this.timeSpan,
    required this.hour,
    required this.minute,
    required this.second,
    required this.question,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.answers,
    required this.mark,
    required this.examId,
    required this.exam,
    required this.updated,
    required this.createdDate,
    required this.createdBy,
    required this.modifiedDate,
    required this.modifiedBy,
    required this.id,
  });
}