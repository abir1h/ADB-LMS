import '../data_sources/remote/password_change_data_source.dart';
import '../../domain/repositories/password_change_repository.dart';
import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/data/models/response_model.dart';
import '../../../shared/domain/entities/response_entity.dart';

class PasswordChangeRepositoryImp extends PasswordChangeRepository {
  final PasswordChangeDataSource passwordChangeDataSource;
  PasswordChangeRepositoryImp({required this.passwordChangeDataSource});

  @override
  Future<ResponseEntity> requestOtpInformation(String phone) async {
    ResponseModel responseModel =
        (await passwordChangeDataSource.requestOTPAction(phone));
    return ResponseEntity(message: responseModel.message, error: responseModel.error, status: responseModel.status, data: responseModel.data);
  }  @override
  Future<ResponseEntity> validateOtpInformation(String phone,String otp) async {
    ResponseModel responseModel =
        (await passwordChangeDataSource.validateOtpAction(phone,otp));
    return ResponseEntity(message: responseModel.message, error: responseModel.error, status: responseModel.status, data: responseModel.data);
  }
}
