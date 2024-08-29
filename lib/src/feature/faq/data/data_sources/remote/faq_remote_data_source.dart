import 'package:adb_mobile/src/feature/faq/data/models/faq_data_model.dart';

import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';

abstract class FaqRemoteDataSource {
  Future<ResponseModel> getFaqAction(String userId, String courseId);
  Future<ResponseModel> getCourseFaq(String userId, String courseId,String topicId);
}

class FaqRemoteDataSourceImp extends FaqRemoteDataSource {
  @override
  Future<ResponseModel> getFaqAction(String userId, String courseId) async {
    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.getFaq}?userId=$userId&id=$courseId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => FaqDataModel.listFromJson(json));
    return responseModel;
  }  @override
  Future<ResponseModel> getCourseFaq(String userId, String courseId,String topicId) async {
    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.getFaq}?userId=$userId&id=$courseId&topicId=$topicId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => FaqDataModel.listFromJson(json));
    return responseModel;
  }
}
