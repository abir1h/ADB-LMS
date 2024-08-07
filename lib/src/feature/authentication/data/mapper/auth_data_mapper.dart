import '../models/auth_data_model.dart';
import '../../domain/entities/auth_data_entity.dart';

abstract class AuthDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _AuthDataModelToEntityMapper
    extends AuthDataMapper<AuthDataModel, AuthDataEntity> {
  @override
  AuthDataModel fromEntityToModel(AuthDataEntity entity) {
    return AuthDataModel(
      id: entity.id,
      userId: entity.userId,
      userName: entity.userName,
      token: entity.token,
      refreshToken: entity.refreshToken,
      email: entity.email,
      validaty: entity.validaty,
      expiredTime: entity.expiredTime,
      roles: entity.roles,
    );
  }

  @override
  AuthDataEntity toEntityFromModel(AuthDataModel model) {
    return AuthDataEntity(
      id: model.id,
      userId: model.userId,
      userName: model.userName,
      token: model.token,
      refreshToken: model.refreshToken,
      email: model.email,
      validaty: model.validaty,
      expiredTime: model.expiredTime,
      roles: model.roles,
    );
  }
}

extension AuthDataModelExt on AuthDataModel {
  AuthDataEntity get toAuthDataEntity =>
      _AuthDataModelToEntityMapper().toEntityFromModel(this);
}

extension AuthDataEntityExt on AuthDataEntity {
  AuthDataModel get toAuthDataModel =>
      _AuthDataModelToEntityMapper().fromEntityToModel(this);
}
