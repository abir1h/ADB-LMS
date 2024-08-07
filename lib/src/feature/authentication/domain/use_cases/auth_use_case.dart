import '../entities/auth_data_entity.dart';
import '../repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _authRepository;
  AuthUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  Future<AuthDataEntity> userLoginUseCase(String username, String password) async {
    final response = _authRepository.userLogin(username, password);
    return response;
  }

}
