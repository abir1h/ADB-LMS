import 'package:adb_mobile/src/feature/course/data/mapper/topic_data_mapper.dart';
import 'package:adb_mobile/src/feature/course/data/models/topic_data_model.dart';
import 'package:adb_mobile/src/feature/course/domain/entities/topic_data_entity.dart';

import '../../domain/entities/course_overview_data_entity.dart';
import '../models/course_over_view_data_model.dart';

abstract class CourseOverViewDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _CourseOverViewDataModelToEntityMapper extends CourseOverViewDataMapper<
    CourseOverViewDataModel, CourseOverViewDataEntity> {
  @override
  CourseOverViewDataModel fromEntityToModel(CourseOverViewDataEntity entity) {
    return CourseOverViewDataModel(
        id: entity.id,
        title: entity.title,
        description: entity.description,
        imagePath: entity.imagePath,
        expiryMonth: entity.expiryMonth,
        noOfRating: entity.noOfRating,
        rating: entity.rating,
        code: entity.code,
        topics: List<TopicDataEntity>.from(entity.topics)
            .map((entity) => entity.toTopicDataModel)
            .toList(),
        bookmarked: entity.bookmarked,
        progress: entity.progress,
        enrollment: entity.enrollment,
        isManager: entity.isManager,
        certificateAchieved: entity.certificateAchieved,
        courseTestCompleted: entity.courseTestCompleted);
  }

  @override
  CourseOverViewDataEntity toEntityFromModel(CourseOverViewDataModel model) {
    return CourseOverViewDataEntity(
        id: model.id,
        title: model.title,
        description: model.description,
        imagePath: model.imagePath,
        expiryMonth: model.expiryMonth,
        noOfRating: model.noOfRating,
        rating: model.rating,
        code: model.code,
        topics: List<TopicDataModel>.from(model.topics)
            .map((model) => model.toTopicDataEntity)
            .toList(),
        bookmarked: model.bookmarked,
        progress: model.progress,
        enrollment: model.enrollment,
        isManager: model.isManager,
        certificateAchieved: model.certificateAchieved,
        courseTestCompleted: model.courseTestCompleted);
  }
}

extension CourseOverViewDataModelExt on CourseOverViewDataModel {
  CourseOverViewDataEntity get toCourseOverViewDataEntity =>
      _CourseOverViewDataModelToEntityMapper().toEntityFromModel(this);
}

extension CourseOverViewDataEntityExt on CourseOverViewDataEntity {
  CourseOverViewDataModel get toCourseOverViewDataModel =>
      _CourseOverViewDataModelToEntityMapper().fromEntityToModel(this);
}
