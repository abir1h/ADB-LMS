import 'dart:developer';

import '../../models/exam_result_data_model.dart';
import '../../models/mcq_data_model.dart';
import '../../models/exam_info_data_model.dart';
import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';

abstract class AssessmentDataSource {
  Future<ResponseModel> getExamInfoAction(String materialId, String userId);
  Future<List<McqDataModel>> getQuestionsAction(
      String materialId, String userId);
  Future<ResponseModel> submitExamAction(
      String userId,
      String examId,
      String startTime,
      String endTime,
      bool autoSubmission,
      int testType,
      List<McqDataModel> mcqData);
  Future<List<ExamResultDataModel>> getExamResultAction(
      String materialId, String userId);
}

class AssessmentDataSourceImp extends AssessmentDataSource {
  @override
  Future<ResponseModel> getExamInfoAction(
      String materialId, String userId) async {
    final responseJson = await Server.instance.getRequest(
        url: "${ApiCredential.getExamInfo}$materialId?userId=$userId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => ExamInfoDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<List<McqDataModel>> getQuestionsAction(
      String materialId, String userId) async {
    final responseJson = await Server.instance.getRequest(
        url: "${ApiCredential.getQuestions}$materialId?userId=$userId");
    List<McqDataModel> responseModelList =
        McqDataModel.listFromJson(responseJson['Data']['MCQs']);
    return responseModelList;
  }

  @override
  Future<ResponseModel> submitExamAction(
      String userId,
      String examId,
      String startTime,
      String endTime,
      bool autoSubmission,
      int testType,
      List<McqDataModel> mcqData) async {
    final answerList = <Map<String, dynamic>>[];
    for (var option in mcqData) {
      final answeredOptions = <int>[];
      if (option.isOption1Selected) answeredOptions.add(1);
      if (option.isOption2Selected) answeredOptions.add(2);
      if (option.isOption3Selected) answeredOptions.add(3);
      if (option.isOption4Selected) answeredOptions.add(4);
      if (answeredOptions.isNotEmpty) {
        final answerItem = {
          'Answered': answeredOptions.join(','),
          'QuestionId': option.id,
        };
        answerList.add(answerItem);
      }
    }
    Map<String, dynamic> data = {
      "ExamId": examId,
      "StartTime": startTime,
      "EndTime": endTime,
      "AutoSubmission": autoSubmission,
      "TestType": testType,
      "MCQList": answerList,
      "TFQList": List.empty(),
      "FIGQList": List.empty()
    };
    log(data.toString());
    final responseJson = await Server.instance.postRequest(
        url: "${ApiCredential.saveAnswers}?userId=$userId", postData: data);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => ExamResultDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<List<ExamResultDataModel>> getExamResultAction(
      String materialId, String userId) async {
    final responseJson = await Server.instance.getRequest(
        url: "${ApiCredential.getExamResults}$materialId?userId=$userId");
    List<ExamResultDataModel> responseModelList =
        ExamResultDataModel.listFromJson(responseJson['Data']);
    return responseModelList;
  }
}
