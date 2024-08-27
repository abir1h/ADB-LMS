import '../repositories/password_change_repository.dart';
import '../../../shared/domain/entities/response_entity.dart';

class PasswordChangeUseCase {
  final PasswordChangeRepository _passwordChangeRepository;
  PasswordChangeUseCase({required PasswordChangeRepository passwordRepository})
      : _passwordChangeRepository = passwordRepository;

  Future<ResponseEntity> requestOtpUseCase(String phone) async {
    final response = _passwordChangeRepository.requestOtpInformation(phone);
    return response;
  }

  Future<ResponseEntity> validateOtpUseCase(String phone, String otp) async {
    final response =
        _passwordChangeRepository.validateOtpInformation(phone, otp);
    return response;
  }
}
