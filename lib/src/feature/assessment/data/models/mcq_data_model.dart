class McqDataModel {
  final String type;
  final String id;
  final String question;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final int mark;

  McqDataModel({
    required this.type,
    required this.id,
    required this.question,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.mark,
  });

  factory McqDataModel.fromJson(Map<String, dynamic> json) => McqDataModel(
        type: json["Type"] ?? "",
        id: json["Id"] ?? "",
        question: json["Question"] ?? "",
        option1: json["Option1"] ?? "",
        option2: json["Option2"] ?? "",
        option3: json["Option3"] ?? "",
        option4: json["Option4"] ?? "",
        mark: json["Mark"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "Type": type,
        "Id": id,
        "Question": question,
        "Option1": option1,
        "Option2": option2,
        "Option3": option3,
        "Option4": option4,
        "Mark": mark,
      };

  static List<McqDataModel> listFromJson(List<dynamic> json) {
    return json.isNotEmpty
        ? List.castFrom<dynamic, McqDataModel>(
            json.map((x) => McqDataModel.fromJson(x)).toList())
        : [];
  }
}
