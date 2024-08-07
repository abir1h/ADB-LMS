import '../../../shared/domain/entities/response_entity.dart';
import '../repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _authRepository;
  AuthUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  Future<ResponseEntity> userLoginUseCase(String username, String password) async {
    final response = _authRepository.userLogin(username, password);
    return response;
  }

}
