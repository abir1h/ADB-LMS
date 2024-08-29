import 'package:adb_mobile/src/feature/profile/data/mapper/result_data_mapper.dart';

import '../../domain/entities/trainee_user_data_entity.dart';
import '../models/trainee_user_data_model.dart';

abstract class TraineeUserDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _TraineeUserDataModelToEntityMapper
    extends TraineeUserDataMapper<TraineeUserDataModel, TraineeUserDataEntity> {
  @override
  TraineeUserDataModel fromEntityToModel(TraineeUserDataEntity entity) {
    return TraineeUserDataModel(
        result: entity.result?.toResultDataModel,
        id: entity.id,
        exception: entity.exception,
        status: entity.status,
        isCanceled: entity.isCanceled,
        isCompleted: entity.isCompleted,
        isCompletedSuccessfully: entity.isCompletedSuccessfully,
        creationOptions: entity.creationOptions,
        asyncState: entity.asyncState,
        isFaulted: entity.isFaulted);
  }

  @override
  TraineeUserDataEntity toEntityFromModel(TraineeUserDataModel model) {
    return TraineeUserDataEntity(
        result: model.result?.toResultDataEntity,
        id: model.id,
        exception: model.exception,
        status: model.status,
        isCanceled: model.isCanceled,
        isCompleted: model.isCompleted,
        isCompletedSuccessfully: model.isCompletedSuccessfully,
        creationOptions: model.creationOptions,
        asyncState: model.asyncState,
        isFaulted: model.isFaulted);
  }
}

extension TraineeUserDataModelExt on TraineeUserDataModel {
  TraineeUserDataEntity get toTraineeUserDataEntity =>
      _TraineeUserDataModelToEntityMapper().toEntityFromModel(this);
}

extension TraineeUserDataEntityExt on TraineeUserDataEntity {
  TraineeUserDataModel get toTraineeUserDataModel =>
      _TraineeUserDataModelToEntityMapper().fromEntityToModel(this);
}
