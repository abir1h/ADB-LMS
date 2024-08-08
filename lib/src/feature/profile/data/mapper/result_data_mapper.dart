import 'package:adb_mobile/src/feature/profile/data/models/result_data_model.dart';
import 'package:adb_mobile/src/feature/profile/domain/entities/result_data_entity.dart';

abstract class ResultDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _ResultDataModelToEntityMapper
    extends ResultDataMapper<ResultDataModel, ResultDataEntity> {
  @override
  ResultDataModel fromEntityToModel(ResultDataEntity entity) {
    return ResultDataModel(
        firstName: entity.firstName,
        lastName: entity.lastName,
        email: entity.email,
        dateOfBirth: entity.dateOfBirth,
        dateOfJoining: entity.dateOfJoining,
        lastLogOn: entity.lastLogOn,
        active: entity.active,
        deActivateOn: entity.deActivateOn,
        gender: entity.gender,
        userType: entity.userType,
        loginType: entity.loginType,
        userGroupId: entity.userGroupId,
        userGroup: entity.userGroup,
        imagePath: entity.imagePath,
        address: entity.address,
        specialityId: entity.specialityId,
        speciality: entity.speciality,
        designationId: entity.designationId,
        designation: entity.designation,
        departmentId: entity.departmentId,
        department: entity.department,
        districtId: entity.districtId,
        district: entity.district,
        divisionId: entity.divisionId,
        division: entity.division,
        unitId: entity.unitId,
        unit: entity.unit,
        subUnitId: entity.subUnitId,
        subUnit: entity.subUnit,
        user: entity.user,
        trainee: entity.trainee,
        trainer: entity.trainer,
        admin: entity.admin,
        userRoles: entity.userRoles,
        postLikes: entity.postLikes,
        id: entity.id,
        userName: entity.userName,
        normalizedUserName: entity.normalizedUserName,
        normalizedEmail: entity.normalizedEmail,
        emailConfirmed: entity.emailConfirmed,
        passwordHash: entity.passwordHash,
        securityStamp: entity.securityStamp,
        concurrencyStamp: entity.concurrencyStamp,
        phoneNumber: entity.phoneNumber,
        phoneNumberConfirmed: entity.phoneNumberConfirmed,
        twoFactorEnabled: entity.twoFactorEnabled,
        lockoutEnd: entity.lockoutEnd,
        lockoutEnabled: entity.lockoutEnabled,
        accessFailedCount: entity.accessFailedCount);
  }

  @override
  ResultDataEntity toEntityFromModel(ResultDataModel model) {
    return ResultDataEntity(
        firstName: model.firstName,
        lastName: model.lastName,
        email: model.email,
        dateOfBirth: model.dateOfBirth,
        dateOfJoining: model.dateOfJoining,
        lastLogOn: model.lastLogOn,
        active: model.active,
        deActivateOn: model.deActivateOn,
        gender: model.gender,
        userType: model.userType,
        loginType: model.loginType,
        userGroupId: model.userGroupId,
        userGroup: model.userGroup,
        imagePath: model.imagePath,
        address: model.address,
        specialityId: model.specialityId,
        speciality: model.speciality,
        designationId: model.designationId,
        designation: model.designation,
        departmentId: model.departmentId,
        department: model.department,
        districtId: model.districtId,
        district: model.district,
        divisionId: model.divisionId,
        division: model.division,
        unitId: model.unitId,
        unit: model.unit,
        subUnitId: model.subUnitId,
        subUnit: model.subUnit,
        user: model.user,
        trainee: model.trainee,
        trainer: model.trainer,
        admin: model.admin,
        userRoles: model.userRoles,
        postLikes: model.postLikes,
        id: model.id,
        userName: model.userName,
        normalizedUserName: model.normalizedUserName,
        normalizedEmail: model.normalizedEmail,
        emailConfirmed: model.emailConfirmed,
        passwordHash: model.passwordHash,
        securityStamp: model.securityStamp,
        concurrencyStamp: model.concurrencyStamp,
        phoneNumber: model.phoneNumber,
        phoneNumberConfirmed: model.phoneNumberConfirmed,
        twoFactorEnabled: model.twoFactorEnabled,
        lockoutEnd: model.lockoutEnd,
        lockoutEnabled: model.lockoutEnabled,
        accessFailedCount: model.accessFailedCount);
  }
}

extension ResultDataModelExt on ResultDataModel {
  ResultDataEntity get toResultDataEntity =>
      _ResultDataModelToEntityMapper().toEntityFromModel(this);
}

extension ResultDataEntityExt on ResultDataEntity {
  ResultDataModel get toResultDataModel =>
      _ResultDataModelToEntityMapper().fromEntityToModel(this);
}
