import 'dart:convert';
import 'dart:io';

import 'package:adb_mobile/src/feature/dashboard/data/models/trainee_count_data_model.dart';

import '../../../../../core/constants/urls.dart';
import '../../../../../core/network/api_service.dart';
import '../../../../shared/data/models/response_model.dart';

abstract class TraineeCountRemoteDataSource {
  Future<ResponseModel> traineeCountAction(String userId);
}

class TraineeCountRemoteDataSourceImp extends TraineeCountRemoteDataSource {
  @override
  Future<ResponseModel> traineeCountAction(String userId) async {
    final responseJson = await Server.instance
        .getRequest(url: "${ApiCredential.getTraineeCount}?userId=$userId");
    ResponseModel responseModel = ResponseModel.fromJson(
        responseJson, (dynamic json) => TraineeCountDataModel.fromJson(json));
    return responseModel;
  }
}
