import 'package:adb_mobile/src/feature/authentication/data/mapper/institute_data_mapper.dart';
import 'package:adb_mobile/src/feature/authentication/data/models/institute_data_model.dart';
import 'package:adb_mobile/src/feature/authentication/domain/entities/institute_data_entity.dart';

import '../../domain/entities/institute_list_data_entity.dart';
import '../models/institute_list_data_model.dart';

abstract class InstituteListDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _InstituteListDataModelToEntityMapper extends InstituteListDataMapper<
    InstituteListDataModel, InstituteListDataEntity> {
  @override
  InstituteListDataModel fromEntityToModel(InstituteListDataEntity entity) {
    return InstituteListDataModel(
        data: List<InstituteDataEntity>.from(entity.data)
            .map((entity) => entity.toInstituteDataModel)
            .toList(),
        message: entity.message,
        status: entity.status);
  }

  @override
  InstituteListDataEntity toEntityFromModel(InstituteListDataModel model) {
    return InstituteListDataEntity(
        data: List<InstituteDataModel>.from(model.data)
            .map((model) => model.toInstituteDataEntity)
            .toList(),
        message: model.message,
        status: model.status);
  }
}

extension InstituteListDataModelExt on InstituteListDataModel {
  InstituteListDataEntity get toInstituteListDataEntity =>
      _InstituteListDataModelToEntityMapper().toEntityFromModel(this);
}

extension InstituteListDataEntityExt on InstituteListDataEntity {
  InstituteListDataModel get toInstituteListDataModel =>
      _InstituteListDataModelToEntityMapper().fromEntityToModel(this);
}
