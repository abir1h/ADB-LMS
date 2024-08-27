import '../../domain/entities/otp_validation_data_entity.dart';
import '../models/otp_validation_data_model.dart';

abstract class OtpValidationDataMapper<M, E> {
  M fromEntityToModel(E entity);

  E toEntityFromModel(M model);
}

class _OtpValidationDataModelToEntityMapper extends OtpValidationDataMapper<
    OtpValidationDataModel, OtpValidationDataEntity> {
  @override
  OtpValidationDataModel fromEntityToModel(OtpValidationDataEntity entity) {
    return OtpValidationDataModel(
        expireTime: entity.expireTime, otp: entity.otp);
  }

  @override
  OtpValidationDataEntity toEntityFromModel(OtpValidationDataModel model) {
    return OtpValidationDataEntity(
        expireTime: model.expireTime, otp: model.otp);
  }
}

extension OtpValidationDataModelExt on OtpValidationDataModel {
  OtpValidationDataEntity get toOtpValidationDataEntity =>
      _OtpValidationDataModelToEntityMapper().toEntityFromModel(this);
}

extension OtpValidationDataEntityExt on OtpValidationDataEntity {
  OtpValidationDataModel get toOtpValidationDataModel =>
      _OtpValidationDataModelToEntityMapper().fromEntityToModel(this);
}
