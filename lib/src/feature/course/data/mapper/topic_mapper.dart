import '../../domain/entities/topic_entity.dart';
import '../models/topic_model.dart';

abstract class TopicMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _TopicModelToEntityMapper extends TopicMapper<TopicModel, TopicEntity> {
  @override
  TopicModel fromEntityToModel(TopicEntity entity) {
    return TopicModel(
        courseId: entity.courseId,
        course: entity.course,
        title: entity.title,
        sequence: entity.sequence,
        materials: entity.materials,
        topicPrePostTests: entity.topicPrePostTests,
        createdDate: entity.createdDate,
        createdBy: entity.createdBy,
        modifiedDate: entity.modifiedDate,
        modifiedBy: entity.modifiedBy,
        id: entity.id);
  }

  @override
  TopicEntity toEntityFromModel(TopicModel model) {
    return TopicEntity(
        courseId: model.courseId,
        course: model.course,
        title: model.title,
        sequence: model.sequence,
        materials: model.materials,
        topicPrePostTests: model.topicPrePostTests,
        createdDate: model.createdDate,
        createdBy: model.createdBy,
        modifiedDate: model.modifiedDate,
        modifiedBy: model.modifiedBy,
        id: model.id);
  }
}

extension TopicModelExt on TopicModel {
  TopicEntity get toTopicEntity =>
      _TopicModelToEntityMapper().toEntityFromModel(this);
}

extension TopicEntityExt on TopicEntity {
  TopicModel get toTopicModel =>
      _TopicModelToEntityMapper().fromEntityToModel(this);
}
