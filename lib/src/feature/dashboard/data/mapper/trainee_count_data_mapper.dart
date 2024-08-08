import '../../domain/entities/trainee_count_data_entity.dart';
import '../models/trainee_count_data_model.dart';

abstract class TraineeCountDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _TraineeCountDataModelToEntityMapper extends TraineeCountDataMapper<
    TraineeCountDataModel, TraineeCountDataEntity> {
  @override
  TraineeCountDataModel fromEntityToModel(TraineeCountDataEntity entity) {
    return TraineeCountDataModel(
        enrollments: entity.enrollments,
        bookmarks: entity.bookmarks,
        certificates: entity.certificates,
        examTaken: entity.examTaken);
  }

  @override
  TraineeCountDataEntity toEntityFromModel(TraineeCountDataModel model) {
    return TraineeCountDataEntity(
        enrollments: model.enrollments,
        bookmarks: model.bookmarks,
        certificates: model.certificates,
        examTaken: model.examTaken);
  }
}

extension TraineeCountDataModelExt on TraineeCountDataModel {
  TraineeCountDataEntity get toTraineeCountDataEntity =>
      _TraineeCountDataModelToEntityMapper().toEntityFromModel(this);
}

extension TraineeCountDataEntityExt on TraineeCountDataEntity {
  TraineeCountDataModel get toTraineeCountDataModel =>
      _TraineeCountDataModelToEntityMapper().fromEntityToModel(this);
}
