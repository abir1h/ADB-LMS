import '../../domain/entities/district_info_data_entity.dart';
import '../models/district_info_data_model.dart';

abstract class DistrictInfoDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _DistrictInfoDataModelToEntityMapper extends DistrictInfoDataMapper<
    DistrictInfoDataModel, DistrictInfoDataEntity> {
  @override
  DistrictInfoDataModel fromEntityToModel(DistrictInfoDataEntity entity) {
    return DistrictInfoDataModel(id: entity.id, name: entity.name);
  }

  @override
  DistrictInfoDataEntity toEntityFromModel(DistrictInfoDataModel model) {
    return DistrictInfoDataEntity(id: model.id, name: model.name);
  }
}

extension DistrictInfoDataModelExt on DistrictInfoDataModel {
  DistrictInfoDataEntity get toDistrictInfoDataEntity =>
      _DistrictInfoDataModelToEntityMapper().toEntityFromModel(this);
}

extension DistrictInfoDataEntityExt on DistrictInfoDataEntity {
  DistrictInfoDataModel get toDistrictInfoDataModel =>
      _DistrictInfoDataModelToEntityMapper().fromEntityToModel(this);
}
