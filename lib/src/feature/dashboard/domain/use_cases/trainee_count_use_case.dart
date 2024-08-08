import 'package:adb_mobile/src/feature/dashboard/domain/repositories/trainee_count_repository.dart';
import 'package:adb_mobile/src/feature/profile/domain/repositories/profile_repository.dart';

import '../../../shared/domain/entities/response_entity.dart';

class TraineeCountUseCase {
  final TraineeCountRepository _traineeCountRepository;
  TraineeCountUseCase({required TraineeCountRepository traineeCountRepository})
      : _traineeCountRepository = traineeCountRepository;

  Future<ResponseEntity> traineeCountInformationUseCase(String userId) async {
    final response = _traineeCountRepository.traineeCountInformation(userId);
    return response;
  }
}
