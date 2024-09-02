import 'package:adb_mobile/src/feature/authentication/data/models/institute_data_model.dart';

import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/auth_data_model.dart';
import '../../models/district_info_data_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthDataModel> userLoginAction(String username, String password);
  Future<ResponseModel> getDistrictDropdownAction();
  Future<ResponseModel> getInstituteDropdownAction();
}

class AuthRemoteDataSourceImp extends AuthRemoteDataSource {
  @override
  Future<AuthDataModel> userLoginAction(
      String username, String password) async {
    Map<String, dynamic> data = {
      "Username": username,
      "Password": password,
      // "LoginType": 0
    };
    final responseJson = await Server.instance
        .postRequest(url: ApiCredential.login, postData: data);
    if (responseJson is String) {
      Map<String, String> data = {"Data": responseJson.toString()};
      AuthDataModel authDataModel = AuthDataModel.fromJson(data);
      return authDataModel;
    } else {
      AuthDataModel authDataModel = AuthDataModel.fromJson(responseJson);
      return authDataModel;
    }
  }

  @override
  Future<ResponseModel> getDistrictDropdownAction() async {
    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.getDistrict}?userId=");
    ResponseModel responseModel = ResponseModel.fromJson(responseJson,
        (dynamic json) => DistrictInfoDataModel.listFromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> getInstituteDropdownAction() async {
    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.getFinancialInstitute}?userId=");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => InstituteDataModel.listFromJson(json));
    return responseModel;
  }
}
