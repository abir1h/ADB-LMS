import '../../../../shared/data/models/response_model.dart';
import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../models/auth_data_model.dart';

abstract class AuthRemoteDataSource {
  Future<ResponseModel> userLoginAction(String username, String password);
}

class AuthRemoteDataSourceImp extends AuthRemoteDataSource {
  @override
  Future<ResponseModel> userLoginAction(
      String username, String password) async {
    Map<String, String> data = {
      "Username": username,
      "Password": password,
    };
    final responseJson = await Server.instance
        .postRequest(url: ApiCredential.login, postData: data);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => AuthDataModel.fromJson(json));
    return responseModel;
  }
}
