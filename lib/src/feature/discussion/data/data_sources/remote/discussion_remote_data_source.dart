import 'package:adb_mobile/src/feature/discussion/data/models/discussion_data_model.dart';

import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/video_dropdown_data_model.dart';

abstract class DiscussionRemoteDataSource {
  Future<ResponseModel> getDiscussion(String userId, String courseId);
  Future<ResponseModel> getVideoDropDown(
      String userId, String courseId, String type, String topicId);
}

class DiscussionRemoteDataSourceImp extends DiscussionRemoteDataSource {
  @override
  Future<ResponseModel> getDiscussion(String userId, String courseId) async {
    final responseJson = await Server.instance.getRequest(
        url: "${ApiCredential.getDiscussion}$courseId?userId=$userId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => DiscussionDataModel.listFromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getVideoDropDown(
      String userId, String courseId, String type, String topicId) async {
    final responseJson = await Server.instance.getRequest(
        url:
            "${ApiCredential.getVideoDropdown}?userId=$userId&disscussionType=$type&courseId=$courseId&topicId=$topicId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => VideoDropdownDataModel.listFromJson(json));
    return responseModel;
  }
}
