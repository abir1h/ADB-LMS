import '../../domain/entities/district_info_data_entity.dart';
import '../../domain/entities/institute_data_entity.dart';
import '../models/district_info_data_model.dart';
import '../models/institute_data_model.dart';

abstract class InstituteDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _InstituteDataModelToEntityMapper
    extends InstituteDataMapper<InstituteDataModel, InstituteDataEntity> {
  @override
  InstituteDataModel fromEntityToModel(InstituteDataEntity entity) {
    return InstituteDataModel(id: entity.id, name: entity.name);
  }

  @override
  InstituteDataEntity toEntityFromModel(InstituteDataModel model) {
    return InstituteDataEntity(id: model.id, name: model.name);
  }
}

extension InstituteDataModelExt on InstituteDataModel {
  InstituteDataEntity get toInstituteDataEntity =>
      _InstituteDataModelToEntityMapper().toEntityFromModel(this);
}

extension InstituteDataEntityExt on InstituteDataEntity {
  InstituteDataModel get toInstituteDataModel =>
      _InstituteDataModelToEntityMapper().fromEntityToModel(this);
}
