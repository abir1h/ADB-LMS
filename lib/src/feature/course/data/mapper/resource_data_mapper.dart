import 'package:adb_mobile/src/feature/dashboard/data/mapper/course_info_data_mapper.dart';
import 'package:adb_mobile/src/feature/dashboard/data/models/course_info_data_model.dart';
import 'package:adb_mobile/src/feature/dashboard/domain/entities/course_info_data_entity.dart';

import '../../domain/entities/course_list_data_entity.dart';
import '../../domain/entities/resource_data_entity.dart';
import '../models/course_list_data_model.dart';
import '../models/resource_data_model.dart';

abstract class ResourceDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _ResourceDataModelToEntityMapper
    extends ResourceDataMapper<ResourceDataModel, ResourceDataEntity> {
  @override
  ResourceDataModel fromEntityToModel(ResourceDataEntity entity) {
    return ResourceDataModel(
        materialId: entity.materialId,
        title: entity.title,
        filePath: entity.filePath,
        fileSizekb: entity.fileSizekb);
  }

  @override
  ResourceDataEntity toEntityFromModel(ResourceDataModel model) {
    return ResourceDataEntity(
        materialId: model.materialId,
        title: model.title,
        filePath: model.filePath,
        fileSizekb: model.fileSizekb);
  }
}

extension ResourceDataModelExt on ResourceDataModel {
  ResourceDataEntity get toResourceDataEntity =>
      _ResourceDataModelToEntityMapper().toEntityFromModel(this);
}

extension ResourceDataEntityExt on ResourceDataEntity {
  ResourceDataModel get toResourceDataModel =>
      _ResourceDataModelToEntityMapper().fromEntityToModel(this);
}
