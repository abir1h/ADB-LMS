import 'package:adb_mobile/src/feature/certificate/data/mapper/certificate_data_mapper.dart';
import 'package:adb_mobile/src/feature/certificate/data/models/Certificate_data_model.dart';

import '../../domain/entities/certificate_data_entity.dart';
import '../../domain/entities/certificate_list_data_entity.dart';
import '../models/certificate_list_data_model.dart';

abstract class CertificateListDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _CertificateListDataModelToEntityMapper extends CertificateListDataMapper<
    CertificateListDataModel, CertificateListDataEntity> {
  @override
  CertificateListDataModel fromEntityToModel(CertificateListDataEntity entity) {
    return CertificateListDataModel(
        data: List<CertificateDataEntity>.from(entity.data)
            .map((entity) => entity.toCertificateDataModel)
            .toList(),
        total: entity.total);
  }

  @override
  CertificateListDataEntity toEntityFromModel(CertificateListDataModel model) {
    return CertificateListDataEntity(
        data: List<CertificateDataModel>.from(model.data)
            .map((model) => model.toCertificateDataEntity)
            .toList(),
        total: model.total);
  }
}

extension CertificateListDataModelExt on CertificateListDataModel {
  CertificateListDataEntity get toCertificateListDataEntity =>
      _CertificateListDataModelToEntityMapper().toEntityFromModel(this);
}

extension CertificateListDataEntityExt on CertificateListDataEntity {
  CertificateListDataModel get toCertificateListDataModel =>
      _CertificateListDataModelToEntityMapper().fromEntityToModel(this);
}
