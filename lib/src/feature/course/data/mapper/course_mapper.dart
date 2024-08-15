import '../../domain/entities/course_entity.dart';
import '../models/course_model.dart';

abstract class CourseMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _CourseModelToEntityMapper
    extends CourseMapper<CourseModel, CourseEntity> {
  @override
  CourseModel fromEntityToModel(CourseEntity entity) {
    return CourseModel(
        id: entity.id,
        title: entity.title,
        description: entity.description,
        imagePath: entity.imagePath,
        rating: entity.rating,
        noOfRating: entity.noOfRating,
        published: entity.published,
        bookmarked: entity.bookmarked,
        progress: entity.progress);
  }

  @override
  CourseEntity toEntityFromModel(CourseModel model) {
    return CourseEntity(
        id: model.id,
        title: model.title,
        description: model.description,
        imagePath: model.imagePath,
        rating: model.rating,
        noOfRating: model.noOfRating,
        published: model.published,
        bookmarked: model.bookmarked,
        progress: model.progress);
  }
}

extension CourseModelExt on CourseModel {
  CourseEntity get toCourseEntity =>
      _CourseModelToEntityMapper().toEntityFromModel(this);
}

extension CourseEntityExt on CourseEntity {
  CourseModel get toCourseModel =>
      _CourseModelToEntityMapper().fromEntityToModel(this);
}
