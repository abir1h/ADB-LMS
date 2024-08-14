import 'package:adb_mobile/src/feature/certificate/data/models/certificate_list_data_model.dart';
import 'package:adb_mobile/src/feature/course/data/models/course_over_view_data_model.dart';

import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';

abstract class CertificateRemoteDataSource {
  Future<ResponseModel> getCertificateAction(String userId);
}

class CertificateRemoteDataSourceImp extends CertificateRemoteDataSource {
  @override
  Future<ResponseModel> getCertificateAction(String userId) async {
    final responseJson = await Server.instance.getRequest(
        url: "${ApiCredential.getCertificates}?userId=$userId&size=8&pageNumber=0");
    ResponseModel responseModel = ResponseModel.fromJson(responseJson,
        (dynamic json) => CertificateListDataModel.fromJson(json));
    return responseModel;
  }
}
