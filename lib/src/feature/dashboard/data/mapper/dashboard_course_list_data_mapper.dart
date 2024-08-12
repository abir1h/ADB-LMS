import 'package:adb_mobile/src/feature/dashboard/data/mapper/course_info_data_mapper.dart';
import 'package:adb_mobile/src/feature/dashboard/data/models/course_info_data_model.dart';
import 'package:adb_mobile/src/feature/dashboard/domain/entities/course_info_data_entity.dart';

import '../../domain/entities/dashbaord_course_list_data_entity.dart';
import '../../domain/entities/trainee_count_data_entity.dart';
import '../models/dashboard_course_list_data_model.dart';
import '../models/trainee_count_data_model.dart';

abstract class DashboardCourseListDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _DashboardCourseListDataModelToEntityMapper
    extends DashboardCourseListDataMapper<DashboardCourseListDataModel,
        DashboardCourseListDataEntity> {
  @override
  DashboardCourseListDataModel fromEntityToModel(
      DashboardCourseListDataEntity entity) {
    return DashboardCourseListDataModel(
        data: List<CourseInfoDataEntity>.from(entity.data)
            .map((entity) => entity.toCourseInfoDataModel)
            .toList(),
        key: entity.key);
  }

  @override
  DashboardCourseListDataEntity toEntityFromModel(
      DashboardCourseListDataModel model) {
    return DashboardCourseListDataEntity(
        data: List<CourseInfoDataModel>.from(model.data)
            .map((model) => model.toCourseInfoDataEntity)
            .toList(),
        key: model.key);
  }
}

extension DashboardCourseListDataModelExt on DashboardCourseListDataModel {
  DashboardCourseListDataEntity get toDashboardCourseListDataEntity =>
      _DashboardCourseListDataModelToEntityMapper().toEntityFromModel(this);
}

extension DashboardCourseListDataEntityExt on DashboardCourseListDataEntity {
  DashboardCourseListDataModel get toDashboardCourseListDataModel =>
      _DashboardCourseListDataModelToEntityMapper().fromEntityToModel(this);
}
