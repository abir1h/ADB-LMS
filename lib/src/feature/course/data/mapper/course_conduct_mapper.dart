import 'package:adb_mobile/src/feature/course/data/mapper/course_mapper.dart';
import 'package:adb_mobile/src/feature/course/data/mapper/material_mapper.dart';
import 'package:adb_mobile/src/feature/course/data/mapper/topic_mapper.dart';
import 'package:adb_mobile/src/feature/course/data/models/material_model.dart';
import 'package:adb_mobile/src/feature/course/domain/entities/material_entity.dart';

import '../../domain/entities/course_conduct_data_entity.dart';
import '../models/course_conduct_data_model.dart';

abstract class CourseConductDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _CourseConductDataModelToEntityMapper extends CourseConductDataMapper<
    CourseConductDataModel, CourseConductDataEntity> {
  @override
  CourseConductDataModel fromEntityToModel(CourseConductDataEntity entity) {
    return CourseConductDataModel(
      course: entity.course?.toCourseModel,
      topic: entity.topic?.toTopicModel,
      progress: entity.progress,
      materials: List<MaterialEntity>.from(entity.materials!)
          .map((entity) => entity.toMaterialModel)
          .toList(),
    );
  }

  @override
  CourseConductDataEntity toEntityFromModel(CourseConductDataModel model) {
    return CourseConductDataEntity(
      course: model.course?.toCourseEntity,
      topic: model.topic?.toTopicEntity,
      progress: model.progress,
      materials: List<MaterialModel>.from(model.materials!)
          .map((model) => model.toMaterialEntity)
          .toList(),
    );
  }
}

extension CourseConductDataModelExt on CourseConductDataModel {
  CourseConductDataEntity get toCourseConductDataEntity =>
      _CourseConductDataModelToEntityMapper().toEntityFromModel(this);
}

extension CourseConductDataEntityExt on CourseConductDataEntity {
  CourseConductDataModel get toCourseConductDataModel =>
      _CourseConductDataModelToEntityMapper().fromEntityToModel(this);
}
