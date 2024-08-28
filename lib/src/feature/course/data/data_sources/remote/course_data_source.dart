import '../../models/course_conduct_data_model.dart';
import '../../models/course_over_view_data_model.dart';
import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/course_list_data_model.dart';

abstract class CourseRemoteDataSource {
  Future<ResponseModel> getCourseAction(String userId);
  Future<ResponseModel> getCourseOverViewAction(String userId, String courseId);
  Future<ResponseModel> getCourseTopicDetailsAction(
      String userId, String courseId, String topicId);
  Future<ResponseModel> contentStudyAction(
      String userId, String materialId, int studyTimeSec);
}

class CourseRemoteDataSourceImp extends CourseRemoteDataSource {
  @override
  Future<ResponseModel> getCourseAction(String userId) async {
    final responseJson = await Server.instance.getRequest(
        url: "${ApiCredential.getCourse}?userId=$userId&size=8&pageNumber=0");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => CourseListDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getCourseOverViewAction(
      String userId, String courseId) async {
    final responseJson = await Server.instance.getRequest(
        url: "${ApiCredential.getCourseOverview}?userId=$userId&id=$courseId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => CourseOverViewDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getCourseTopicDetailsAction(
      String userId, String courseId, String topicId) async {
    final responseJson = await Server.instance.getRequest(
        url:
            "${ApiCredential.getCourseTopicDetails}?userId=$userId&courseId=$courseId&topicId=$topicId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => CourseConductDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> contentStudyAction(
      String userId, String materialId, int studyTimeSec) async {
    final responseJson = await Server.instance.getRequest(
        url:
            "${ApiCredential.contentStudy}?userId=$userId&materialId=$materialId&studyTimeSec=$studyTimeSec");
    ResponseModel responseModel = ResponseModel(
        message: responseJson['Message'],
        status: responseJson['Status'],
        error: responseJson['Error'],
        data: null);
    return responseModel;
  }
}
