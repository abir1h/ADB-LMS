import '../../../shared/domain/entities/response_entity.dart';
import '../entities/auth_data_entity.dart';

abstract class AuthRepository {
  Future<AuthDataEntity> userLogin(String username, String password);
  Future<ResponseEntity> getDistrictDropdown();
  Future<ResponseEntity> getInstituteDropdown();
}