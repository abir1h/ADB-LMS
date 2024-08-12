import 'package:adb_mobile/src/feature/dashboard/data/mapper/course_info_data_mapper.dart';
import 'package:adb_mobile/src/feature/dashboard/data/models/course_info_data_model.dart';
import 'package:adb_mobile/src/feature/dashboard/domain/entities/course_info_data_entity.dart';

import '../../domain/entities/course_list_data_entity.dart';
import '../models/course_list_data_model.dart';

abstract class CourseListDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _CourseListDataModelToEntityMapper
    extends CourseListDataMapper<CourseListDataModel, CourseListDataEntity> {
  @override
  CourseListDataModel fromEntityToModel(CourseListDataEntity entity) {
    return CourseListDataModel(
        data: List<CourseInfoDataEntity>.from(entity.data)
            .map((entity) => entity.toCourseInfoDataModel)
            .toList(),
        total: entity.total);
  }

  @override
  CourseListDataEntity toEntityFromModel(CourseListDataModel model) {
    return CourseListDataEntity(
        data: List<CourseInfoDataModel>.from(model.data)
            .map((model) => model.toCourseInfoDataEntity)
            .toList(),
        total: model.total);
  }
}

extension CourseListDataModelExt on CourseListDataModel {
  CourseListDataEntity get toCourseListDataEntity =>
      _CourseListDataModelToEntityMapper().toEntityFromModel(this);
}

extension CourseListDataEntityExt on CourseListDataEntity {
  CourseListDataModel get toCourseListDataModel =>
      _CourseListDataModelToEntityMapper().fromEntityToModel(this);
}
