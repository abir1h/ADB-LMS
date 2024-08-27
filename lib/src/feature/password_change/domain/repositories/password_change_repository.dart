import '../../../shared/domain/entities/response_entity.dart';

abstract class PasswordChangeRepository {
  Future<ResponseEntity> requestOtpInformation(String phone);
  Future<ResponseEntity> validateOtpInformation(String phone,String otp);
  Future<ResponseEntity> resetOtpInformation(String phone, String Otp, String password);
}
