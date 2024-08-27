import 'package:adb_mobile/src/feature/password_change/data/mapper/otp_validation_data_mapper.dart';
import 'package:adb_mobile/src/feature/password_change/domain/entities/otp_validation_data_entity.dart';

import '../data_sources/remote/password_change_data_source.dart';
import '../../domain/repositories/password_change_repository.dart';
import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/data/models/response_model.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../models/otp_validation_data_model.dart';

class PasswordChangeRepositoryImp extends PasswordChangeRepository {
  final PasswordChangeDataSource passwordChangeDataSource;
  PasswordChangeRepositoryImp({required this.passwordChangeDataSource});

  @override
  Future<ResponseEntity> requestOtpInformation(String phone) async {
    ResponseModel responseModel =
        (await passwordChangeDataSource.requestOTPAction(phone));
    return ResponseEntity(
        message: responseModel.message,
        error: responseModel.error,
        status: responseModel.status,
        data: responseModel.data);
  }

  @override
  Future<ResponseEntity> validateOtpInformation(
      String phone, String otp) async {
    ResponseModel responseModel =
        (await passwordChangeDataSource.validateOtpAction(phone, otp));
    return ResponseModelToEntityMapper<OtpValidationDataEntity,
            OtpValidationDataModel>()
        .toEntityFromModel(responseModel,
            (OtpValidationDataModel model) => model.toOtpValidationDataEntity);
  }

  @override
  Future<ResponseEntity> resetOtpInformation(
      String phone, String Otp, String password) async {
    ResponseModel responseModel =
        (await passwordChangeDataSource.resetOtpAction(phone, Otp, password));
    return ResponseEntity(
        message: responseModel.message,
        error: responseModel.error,
        status: responseModel.status,
        data: responseModel.data);
  }
}
