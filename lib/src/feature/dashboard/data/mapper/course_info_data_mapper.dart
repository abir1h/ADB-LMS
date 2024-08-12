import 'package:adb_mobile/src/feature/dashboard/data/mapper/trainee_course_data_mapper.dart';

import '../../domain/entities/course_info_data_entity.dart';
import '../../domain/entities/trainee_count_data_entity.dart';
import '../../domain/entities/trainee_course_data_entity.dart';
import '../models/course_info_data_model.dart';
import '../models/trainee_count_data_model.dart';
import '../models/trainee_course_data_model.dart';

abstract class CourseInfoDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _CourseInfoDataModelToEntityMapper
    extends CourseInfoDataMapper<CourseInfoDataModel, CourseInfoDataEntity> {
  @override
  CourseInfoDataModel fromEntityToModel(CourseInfoDataEntity entity) {
    return CourseInfoDataModel(
        id: entity.id,
        title: entity.title,
        description: entity.description,
        imagePath: entity.imagePath,
        enrollmentDate: entity.enrollmentDate,
        traineeCourseDataModel:
            entity.traineeCourseDataEntity?.toTraineeCourseDataModel,
        noOfContents: entity.noOfContents,
        noOfContentsStudied: entity.noOfContentsStudied,
        rating: entity.rating,
        noOfRating: entity.noOfRating,
        progress: entity.progress);
  }

  @override
  CourseInfoDataEntity toEntityFromModel(CourseInfoDataModel model) {
    return CourseInfoDataEntity(
        id: model.id,
        title: model.title,
        description: model.description,
        imagePath: model.imagePath,
        enrollmentDate: model.enrollmentDate,
        traineeCourseDataEntity:
            model.traineeCourseDataModel?.toTraineeCourseDataEntity,
        noOfContents: model.noOfContents,
        noOfContentsStudied: model.noOfContentsStudied,
        rating: model.rating,
        noOfRating: model.noOfRating,
        progress: model.progress);
  }
}

extension CourseInfoDataModelExt on CourseInfoDataModel {
  CourseInfoDataEntity get toCourseInfoDataEntity =>
      _CourseInfoDataModelToEntityMapper().toEntityFromModel(this);
}

extension CourseInfoDataEntityExt on CourseInfoDataEntity {
  CourseInfoDataModel get toCourseInfoDataModel =>
      _CourseInfoDataModelToEntityMapper().fromEntityToModel(this);
}
