import 'package:adb_mobile/src/feature/profile/domain/repositories/profile_repository.dart';

import '../../../shared/domain/entities/response_entity.dart';

class UserUseCase {
  final ProfileRepository _userRepository;
  UserUseCase({required ProfileRepository userRepository})
      : _userRepository = userRepository;

  Future<ResponseEntity> userProfileInformationUseCase(String userId) async {
    final response = _userRepository.userProfileInformation(userId);
    return response;
  }
}
