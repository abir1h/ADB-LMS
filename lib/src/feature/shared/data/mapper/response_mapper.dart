import '../../domain/entities/response_entity.dart';
import '../models/response_model.dart';

class ResponseModelToEntityMapper<E, M> {
  ResponseModel fromEntityToModel(
      ResponseEntity entity, M Function(E) fromEntity) {
    return ResponseModel(
        message: entity.message!,
        error: entity.error,
        status: entity.status,
        data: entity.data != null ? fromEntity(entity.data) : null);
  }

  ResponseEntity toEntityFromModel(
      ResponseModel model, E Function(M) fromModel) {
    return ResponseEntity(
        message: model.message,
        error: model.error,
        status: model.status,
        data: model.data != null ? fromModel(model.data) : null);
  }
}
