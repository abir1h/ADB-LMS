import '../../domain/entities/certificate_data_entity.dart';
import '../models/Certificate_data_model.dart';

abstract class CertificateDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _CertificateDataModelToEntityMapper
    extends CertificateDataMapper<CertificateDataModel, CertificateDataEntity> {
  @override
  CertificateDataModel fromEntityToModel(CertificateDataEntity entity) {
    return CertificateDataModel(
        courseId: entity.courseId,
        date: entity.date,
        title: entity.title,
        certificateAchieved: entity.certificateAchieved);
  }

  @override
  CertificateDataEntity toEntityFromModel(CertificateDataModel model) {
    return CertificateDataEntity(
        courseId: model.courseId,
        date: model.date,
        title: model.title,
        certificateAchieved: model.certificateAchieved);
  }
}

extension CertificateDataModelExt on CertificateDataModel {
  CertificateDataEntity get toCertificateDataEntity =>
      _CertificateDataModelToEntityMapper().toEntityFromModel(this);
}

extension CertificateDataEntityExt on CertificateDataEntity {
  CertificateDataModel get toCertificateDataModel =>
      _CertificateDataModelToEntityMapper().fromEntityToModel(this);
}
