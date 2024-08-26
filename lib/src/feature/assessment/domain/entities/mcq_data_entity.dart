class McqDataEntity {
  final String type;
  final String id;
  final String question;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final int mark;
  bool isOption1Selected;
  bool isOption2Selected;
  bool isOption3Selected;
  bool isOption4Selected;

  McqDataEntity(
      {required this.type,
      required this.id,
      required this.question,
      required this.option1,
      required this.option2,
      required this.option3,
      required this.option4,
      required this.mark,
      this.isOption1Selected = false,
      this.isOption2Selected = false,
      this.isOption3Selected = false,
      this.isOption4Selected = false});
}
