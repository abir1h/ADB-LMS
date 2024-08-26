class ExamResultDataEntity {
  final String id;
  final int testType;
  final int quota;
  final int totalMarks;
  final double gainedMarks;
  final String startDate;
  final int noOfCorrectAnsweredQs;
  final int totalQuestions;
  final double scored;
  final bool current;
  final bool nextUnlock;

  ExamResultDataEntity({
    required this.id,
    required this.testType,
    required this.quota,
    required this.totalMarks,
    required this.gainedMarks,
    required this.startDate,
    required this.noOfCorrectAnsweredQs,
    required this.totalQuestions,
    required this.scored,
    required this.current,
    required this.nextUnlock,
  });
}
