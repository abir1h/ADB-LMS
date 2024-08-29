
import '../../../shared/domain/entities/response_entity.dart';

abstract class ProfileRepository {
  Future<ResponseEntity> userProfileInformation(String userId);
}
