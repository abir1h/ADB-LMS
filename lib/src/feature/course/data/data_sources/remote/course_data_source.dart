import 'package:adb_mobile/src/feature/course/data/models/course_over_view_data_model.dart';

import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/course_list_data_model.dart';

abstract class CourseRemoteDataSource {
  Future<ResponseModel> getCourseAction(String userId);
  Future<ResponseModel> getCourseOverViewAction(String userId, String courseId);
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
}
