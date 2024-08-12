import 'material_data_mapper.dart';
import '../models/material_data_model.dart';
import '../../domain/entities/material_data_entity.dart';
import '../../domain/entities/topic_data_entity.dart';
import '../models/topic_data_model.dart';

abstract class TopicDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _TopicDataModelToEntityMapper
    extends TopicDataMapper<TopicDataModel, TopicDataEntity> {
  @override
  TopicDataModel fromEntityToModel(TopicDataEntity entity) {
    return TopicDataModel(
        id: entity.id,
        title: entity.title,
        materials: List<MaterialDataEntity>.from(entity.materials)
            .map((entity) => entity.toMaterialDataModel)
            .toList(),
        progressSum: entity.progressSum,
        materialCount: entity.materialCount,
        progress: entity.progress,
        testsCompleted: entity.testsCompleted);
  }

  @override
  TopicDataEntity toEntityFromModel(TopicDataModel model) {
    return TopicDataEntity(
        id: model.id,
        title: model.title,
        materials: List<MaterialDataModel>.from(model.materials)
            .map((model) => model.toMaterialDataEntity)
            .toList(),
        progressSum: model.progressSum,
        materialCount: model.materialCount,
        progress: model.progress,
        testsCompleted: model.testsCompleted);
  }
}

extension TopicDataModelExt on TopicDataModel {
  TopicDataEntity get toTopicDataEntity =>
      _TopicDataModelToEntityMapper().toEntityFromModel(this);
}

extension TopicDataEntityExt on TopicDataEntity {
  TopicDataModel get toTopicDataModel =>
      _TopicDataModelToEntityMapper().fromEntityToModel(this);
}
