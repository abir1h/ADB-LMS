import '../../../shared/domain/entities/response_entity.dart';

abstract class AuthRepository {
  Future<ResponseEntity> userLogin(String username, String password);
}