import 'dart:convert';
import 'dart:io';

import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';
import '../../models/user_data_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ResponseModel> userProfileInformationAction(String userId);
}

class ProfileRemoteDataSourceImp extends ProfileRemoteDataSource {
  @override
  Future<ResponseModel> userProfileInformationAction(String userId) async {
    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.getProfile}?userId=$userId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => UserDataModel.fromJson(json));
    return responseModel;
  }


}
