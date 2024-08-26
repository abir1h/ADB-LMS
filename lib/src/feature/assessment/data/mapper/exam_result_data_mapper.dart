import '../../domain/entities/exam_info_data_entity.dart';
import '../../domain/entities/exam_result_data_entity.dart';
import '../models/exam_info_data_model.dart';
import '../models/exam_result_data_model.dart';

abstract class ExamResultDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _ExamResultDataModelToEntityMapper
    extends ExamResultDataMapper<ExamResultDataModel, ExamResultDataEntity> {
  @override
  ExamResultDataModel fromEntityToModel(ExamResultDataEntity entity) {
    return ExamResultDataModel(
        id: entity.id,
        testType: entity.testType,
        quota: entity.quota,
        totalMarks: entity.totalMarks,
        gainedMarks: entity.gainedMarks,
        startDate: entity.startDate,
        noOfCorrectAnsweredQs: entity.noOfCorrectAnsweredQs,
        totalQuestions: entity.totalQuestions,
        scored: entity.scored,
        current: entity.current,
        nextUnlock: entity.nextUnlock);
  }

  @override
  ExamResultDataEntity toEntityFromModel(ExamResultDataModel model) {
    return ExamResultDataEntity(
        id: model.id,
        testType: model.testType,
        quota: model.quota,
        totalMarks: model.totalMarks,
        gainedMarks: model.gainedMarks,
        startDate: model.startDate,
        noOfCorrectAnsweredQs: model.noOfCorrectAnsweredQs,
        totalQuestions: model.totalQuestions,
        scored: model.scored,
        current: model.current,
        nextUnlock: model.nextUnlock);
  }
}

extension ExamResultDataModelExt on ExamResultDataModel {
  ExamResultDataEntity get toExamResultDataEntity =>
      _ExamResultDataModelToEntityMapper().toEntityFromModel(this);
}

extension ExamResultDataEntityExt on ExamResultDataEntity {
  ExamResultDataModel get toExamResultDataModel =>
      _ExamResultDataModelToEntityMapper().fromEntityToModel(this);
}
