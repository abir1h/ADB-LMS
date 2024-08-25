import '../../domain/entities/exam_info_data_entity.dart';
import '../models/exam_info_data_model.dart';

abstract class ExamInfoDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _ExamInfoDataModelToEntityMapper
    extends ExamInfoDataMapper<ExamInfoDataModel, ExamInfoDataEntity> {
  @override
  ExamInfoDataModel fromEntityToModel(ExamInfoDataEntity entity) {
    return ExamInfoDataModel(
      id: entity.id,
      topicId: entity.topicId,
      topicTitle: entity.topicTitle,
      examInstructions: entity.examInstructions,
      durationMnt: entity.durationMnt,
      marks: entity.marks,
      examName: entity.examName,
      attempt: entity.attempt,
      pendingQuota: entity.pendingQuota,
      allow: entity.allow,
    );
  }

  @override
  ExamInfoDataEntity toEntityFromModel(ExamInfoDataModel model) {
    return ExamInfoDataEntity(
      id: model.id,
      topicId: model.topicId,
      topicTitle: model.topicTitle,
      examInstructions: model.examInstructions,
      durationMnt: model.durationMnt,
      marks: model.marks,
      examName: model.examName,
      attempt: model.attempt,
      pendingQuota: model.pendingQuota,
      allow: model.allow,
    );
  }
}

extension ExamInfoDataModelExt on ExamInfoDataModel {
  ExamInfoDataEntity get toExamInfoDataEntity =>
      _ExamInfoDataModelToEntityMapper().toEntityFromModel(this);
}

extension ExamInfoDataEntityExt on ExamInfoDataEntity {
  ExamInfoDataModel get toExamInfoDataModel =>
      _ExamInfoDataModelToEntityMapper().fromEntityToModel(this);
}
