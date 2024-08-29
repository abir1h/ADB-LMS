import 'package:adb_mobile/src/feature/course/data/mapper/resource_data_mapper.dart';
import 'package:adb_mobile/src/feature/course/data/models/resource_data_model.dart';
import 'package:adb_mobile/src/feature/course/domain/entities/resource_data_entity.dart';

import '../../domain/entities/material_data_entity.dart';
import '../models/material_data_model.dart';

abstract class MaterialDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _MaterialDataModelToEntityMapper
    extends MaterialDataMapper<MaterialDataModel, MaterialDataEntity> {
  @override
  MaterialDataModel fromEntityToModel(MaterialDataEntity entity) {
    return MaterialDataModel(
        id: entity.id,
        title: entity.title,
        filePath: entity.filePath,
        fileType: entity.fileType,
        fileSizeKb: entity.fileSizeKb,
        requiredStudyTimeSec: entity.requiredStudyTimeSec,
        type: entity.type,
        resources: List<ResourceDataEntity>.from(entity.resources!)
            .map((entity) => entity.toResourceDataModel)
            .toList(),
        dependencies: entity.dependencies,
        progress: entity.progress);
  }

  @override
  MaterialDataEntity toEntityFromModel(MaterialDataModel model) {
    return MaterialDataEntity(
        id: model.id,
        title: model.title,
        filePath: model.filePath,
        fileType: model.fileType,
        fileSizeKb: model.fileSizeKb,
        requiredStudyTimeSec: model.requiredStudyTimeSec,
        type: model.type,
        resources: List<ResourceDataModel>.from(model.resources!)
            .map((model) => model.toResourceDataEntity)
            .toList(),
        dependencies: model.dependencies,
        progress: model.progress);
  }
}

extension MaterialDataModelExt on MaterialDataModel {
  MaterialDataEntity get toMaterialDataEntity =>
      _MaterialDataModelToEntityMapper().toEntityFromModel(this);
}

extension MaterialDataEntityExt on MaterialDataEntity {
  MaterialDataModel get toMaterialDataModel =>
      _MaterialDataModelToEntityMapper().fromEntityToModel(this);
}
