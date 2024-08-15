import 'package:adb_mobile/src/feature/course/data/mapper/resource_data_mapper.dart';
import 'package:adb_mobile/src/feature/course/data/models/resource_data_model.dart';
import 'package:adb_mobile/src/feature/course/domain/entities/resource_data_entity.dart';
import 'package:adb_mobile/src/feature/dashboard/data/mapper/course_info_data_mapper.dart';
import 'package:adb_mobile/src/feature/dashboard/data/models/course_info_data_model.dart';
import 'package:adb_mobile/src/feature/dashboard/domain/entities/course_info_data_entity.dart';

import '../../domain/entities/course_list_data_entity.dart';
import '../../domain/entities/popup_quiz_data_model.dart';
import '../models/course_list_data_model.dart';
import '../models/popup_quiz_data_model.dart';

abstract class PopupQuizDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _PopupQuizDataModelToEntityMapper
    extends PopupQuizDataMapper<PopupQuizDataModel, PopupQuizDataEntity> {
  @override
  PopupQuizDataModel fromEntityToModel(PopupQuizDataEntity entity) {
    return PopupQuizDataModel(
        timeSpan: entity.timeSpan,
        hour: entity.hour,
        minute: entity.minute,
        second: entity.second,
        question: entity.question,
        option1: entity.option1,
        option2: entity.option2,
        option3: entity.option3,
        option4: entity.option4,
        answers: entity.answers,
        mark: entity.mark,
        examId: entity.examId,
        exam: entity.exam,
        updated: entity.updated,
        createdDate: entity.createdDate,
        createdBy: entity.createdBy,
        modifiedDate: entity.modifiedDate,
        modifiedBy: entity.modifiedBy,
        id: entity.id);
  }

  @override
  PopupQuizDataEntity toEntityFromModel(PopupQuizDataModel model) {
    return PopupQuizDataEntity(
        timeSpan: model.timeSpan,
        hour: model.hour,
        minute: model.minute,
        second: model.second,
        question: model.question,
        option1: model.option1,
        option2: model.option2,
        option3: model.option3,
        option4: model.option4,
        answers: model.answers,
        mark: model.mark,
        examId: model.examId,
        exam: model.exam,
        updated: model.updated,
        createdDate: model.createdDate,
        createdBy: model.createdBy,
        modifiedDate: model.modifiedDate,
        modifiedBy: model.modifiedBy,
        id: model.id);
  }
}

extension PopupQuizDataModelExt on PopupQuizDataModel {
  PopupQuizDataEntity get toPopupQuizDataEntity =>
      _PopupQuizDataModelToEntityMapper().toEntityFromModel(this);
}

extension PopupQuizDataEntityExt on PopupQuizDataEntity {
  PopupQuizDataModel get toPopupQuizDataModel =>
      _PopupQuizDataModelToEntityMapper().fromEntityToModel(this);
}
