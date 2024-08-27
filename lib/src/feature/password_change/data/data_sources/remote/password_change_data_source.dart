import 'package:adb_mobile/src/feature/password_change/data/models/otp_validation_data_model.dart';

import '../../../../authentication/data/models/institute_data_model.dart';
import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';

abstract class PasswordChangeDataSource {
  Future<ResponseModel> requestOTPAction(String phone);
  Future<ResponseModel> validateOtpAction(String phone,String Otp);
  Future<ResponseModel> resetOtpAction(String phone,String Otp,String password);
}

class PasswordChangeDataSourceImp extends PasswordChangeDataSource {
  @override
  Future<ResponseModel> requestOTPAction(String phone) async {
    Map<String, dynamic> data = {};
    final responseJson = await Server.instance
        .postRequest(url: "${ApiCredential.requestOtp}$phone?userId=null", postData: data);
    // ResponseModel responseModel = ResponseModel.fromJson(
    //     responseJson, (dynamic json) => AuthDataModel.fromJson(json));
    ResponseModel responseModel = ResponseModel(
        message: responseJson['Message'],
        status: responseJson['Status'],
        data: responseJson['Data'] != null ? responseJson['Data'] as String : "");
    return responseModel;
  }

  @override
  Future<ResponseModel> validateOtpAction(String phone, String Otp) async{

    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.validateOtp}?userId=&phoneNumber=$phone&otp=$Otp",);
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => OtpValidationDataModel.fromJson(json));
    return responseModel;
  }

  @override
  Future<ResponseModel> resetOtpAction(String phone, String Otp, String password) async{
    Map<String, dynamic> data = {
      "Otp":Otp,
      "Password":password,
      "PhoneNumber":phone
    };
    final responseJson = await Server.instance
        .postRequest(url: ApiCredential.resetOtp, postData: data);
    // ResponseModel responseModel = ResponseModel.fromJson(
    //     responseJson, (dynamic json) => AuthDataModel.fromJson(json));
    ResponseModel responseModel = ResponseModel(
        message: responseJson['Message'],
        status: responseJson['Status'],
        data: responseJson['Data'] != null ? responseJson['Data'] as String : "");
    return responseModel;
  }
}
