import 'package:adb_mobile/src/feature/notification/data/models/notification_data_model.dart';

import '../../../../faq/data/models/faq_data_model.dart';
import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';

abstract class NotificationRemoteDataSource {
  Future<ResponseModel> getNotification(String userId);
}

class NotificationRemoteDataSourceImp
    extends NotificationRemoteDataSource {
  @override
  Future<ResponseModel> getNotification(String userId) async {
    final responseJson = await Server.instance.getRequest(
        url:
            "${ApiCredential.getNotification}?userId=$userId&size=10&pageNumber=0&unseenOnly=false");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => NotificationDataModel.fromJson(json));
    return responseModel;
  }
}
