import 'dart:io';

import '../../../shared/domain/entities/response_entity.dart';

abstract class TraineeCountRepository {
  Future<ResponseEntity> traineeCountInformation(String userId);
}
