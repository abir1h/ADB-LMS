import 'package:adb_mobile/src/feature/course/data/models/course_over_view_data_model.dart';
import 'package:adb_mobile/src/feature/faq/data/models/faq_data_model.dart';

import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';

abstract class FaqRemoteDataSource {
  Future<ResponseModel> getFaqAction(String userId, String courseId);
}

class FaqRemoteDataSourceImp extends FaqRemoteDataSource {
  @override
  Future<ResponseModel> getFaqAction(String userId, String courseId) async {
    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.getFaq}?userId=$userId&id=$courseId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => FaqDataModel.listFromJson(json));
    return responseModel;
  }
}
