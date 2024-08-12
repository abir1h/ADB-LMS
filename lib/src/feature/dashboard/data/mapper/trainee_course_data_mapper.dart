import '../../domain/entities/trainee_count_data_entity.dart';
import '../../domain/entities/trainee_course_data_entity.dart';
import '../models/trainee_count_data_model.dart';
import '../models/trainee_course_data_model.dart';

abstract class TraineeCourseDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _TraineeCourseDataModelToEntityMapper extends TraineeCourseDataMapper<
    TraineeCourseDataModel, TraineeCourseDataEntity> {
  @override
  TraineeCourseDataModel fromEntityToModel(TraineeCourseDataEntity entity) {
    return TraineeCourseDataModel(
        totalLectures: entity.totalLectures,
        totalCompltedMockTests: entity.totalCompltedMockTests,
        totalCompltedMaterials: entity.totalCompltedMaterials,
        totalCompletedLectures: entity.totalCompletedLectures);
  }

  @override
  TraineeCourseDataEntity toEntityFromModel(TraineeCourseDataModel model) {
    return TraineeCourseDataEntity(
        totalLectures: model.totalLectures,
        totalCompltedMockTests:  model.totalCompltedMockTests,
        totalCompltedMaterials:  model.totalCompltedMaterials,
        totalCompletedLectures:  model.totalCompletedLectures);
  }
}

extension TraineeCourseDataModelExt on TraineeCourseDataModel {
  TraineeCourseDataEntity get toTraineeCourseDataEntity =>
      _TraineeCourseDataModelToEntityMapper().toEntityFromModel(this);
}

extension TraineeCourseDataEntityExt on TraineeCourseDataEntity {
  TraineeCourseDataModel get toTraineeCourseDataModel =>
      _TraineeCourseDataModelToEntityMapper().fromEntityToModel(this);
}
