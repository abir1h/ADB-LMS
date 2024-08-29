import 'package:adb_mobile/src/feature/profile/data/mapper/trainee_user_data_mapper.dart';

import '../../domain/entities/user_data_entity.dart';
import '../models/user_data_model.dart';

abstract class UserDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _UserDataModelToEntityMapper
    extends UserDataMapper<UserDataModel, UserDataEntity> {
  @override
  UserDataModel fromEntityToModel(UserDataEntity entity) {
    return UserDataModel(
        firstName: entity.firstName,
        lastName: entity.lastName,
        fullName: entity.fullName,
        email: entity.email,
        userName: entity.userName,
        phoneNumber: entity.phoneNumber,
        address: entity.address,
        workLocation: entity.workLocation,
        lineManagerName: entity.lineManagerName,
        lineManagerPin: entity.lineManagerPin,
        active: entity.active,
        gender: entity.gender,
        designation: entity.designation,
        division: entity.division,
        department: entity.department,
        unit: entity.unit,
        subUnit: entity.subUnit,
        dateOfBirth: entity.dateOfBirth,
        dateOfJoining: entity.dateOfJoining,
        position: entity.position,
        traineeUser: entity.traineeUser?.toTraineeUserDataModel,
        imagePath: entity.imagePath);
  }

  @override
  UserDataEntity toEntityFromModel(UserDataModel model) {
    return UserDataEntity(
        firstName: model.firstName,
        lastName: model.lastName,
        fullName: model.fullName,
        email: model.email,
        userName: model.userName,
        phoneNumber: model.phoneNumber,
        address: model.address,
        workLocation: model.workLocation,
        lineManagerName: model.lineManagerName,
        lineManagerPin: model.lineManagerPin,
        active: model.active,
        gender:model. gender,
        designation: model.designation,
        division:model. division,
        department: model.department,
        unit: model.unit,
        subUnit: model.subUnit,
        dateOfBirth: model.dateOfBirth,
        dateOfJoining: model.dateOfJoining,
        position: model.position,
        traineeUser: model.traineeUser?.toTraineeUserDataEntity,
        imagePath: model.imagePath);
  }
}

extension UserDataModelExt on UserDataModel {
  UserDataEntity get toUserDataEntity =>
      _UserDataModelToEntityMapper().toEntityFromModel(this);
}

extension UserDataEntityExt on UserDataEntity {
  UserDataModel get toUserDataModel =>
      _UserDataModelToEntityMapper().fromEntityToModel(this);
}
