import '../../../shared/domain/entities/response_entity.dart';
import '../entities/auth_data_entity.dart';
import '../repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _authRepository;
  AuthUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  Future<AuthDataEntity> userLoginUseCase(
      String username, String password) async {
    final response = _authRepository.userLogin(username, password);
    return response;
  }

  Future<ResponseEntity> getDistrictDropdownUSeCase() async {
    final response = _authRepository.getDistrictDropdown();
    return response;
  }Future<ResponseEntity> getInstituteDropdownUseCase() async {
    final response = _authRepository.getInstituteDropdown();
    return response;
  }
}
