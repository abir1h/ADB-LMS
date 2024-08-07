import '../entities/auth_data_entity.dart';

abstract class AuthRepository {
  Future<AuthDataEntity> userLogin(String username, String password);
}