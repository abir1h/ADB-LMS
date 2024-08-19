import 'package:adb_mobile/src/feature/authentication/data/mapper/district_info_data_mapper.dart';

import '../../domain/entities/district_dropdown_data_entity.dart';
import '../../domain/entities/district_info_data_entity.dart';
import '../models/district_dropdown_data_model.dart';
import '../models/district_info_data_model.dart';

abstract class DistrictDropDownDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _DistrictDropDownDataModelToEntityMapper
    extends DistrictDropDownDataMapper<DistrictDropDownDataModel,
        DistrictDropDownDataEntity> {
  @override
  DistrictDropDownDataModel fromEntityToModel(
      DistrictDropDownDataEntity entity) {
    return DistrictDropDownDataModel(
        data: List<DistrictInfoDataEntity>.from(entity.data)
            .map((entity) => entity.toDistrictInfoDataModel)
            .toList(),
        message: entity.message,
        status: entity.status);
  }

  @override
  DistrictDropDownDataEntity toEntityFromModel(
      DistrictDropDownDataModel model) {
    return DistrictDropDownDataEntity(
        data: List<DistrictInfoDataModel>.from(model.data)
            .map((model) => model.toDistrictInfoDataEntity)
            .toList(),
        message: model.message,
        status: model.status);
  }
}

extension DistrictDropDownDataModelExt on DistrictDropDownDataModel {
  DistrictDropDownDataEntity get toDistrictDropDownDataEntity =>
      _DistrictDropDownDataModelToEntityMapper().toEntityFromModel(this);
}

extension DistrictDropDownDataEntityExt on DistrictDropDownDataEntity {
  DistrictDropDownDataModel get toDistrictDropDownDataModel =>
      _DistrictDropDownDataModelToEntityMapper().fromEntityToModel(this);
}
