import '../../models/exam_info_data_model.dart';
import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';

abstract class AssessmentDataSource {
  Future<ResponseModel> getExamInfoAction(String materialId, String userId);
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
}
