import 'package:flutter/cupertino.dart';

@immutable
class ResultDataModel {
 final String firstName;
 final String lastName;
 final String email;
 final String dateOfBirth;
 final String dateOfJoining;
 final String lastLogOn;
 final bool active;
 final String deActivateOn;
 final int gender;
 final int userType;
 final int loginType;
 final String userGroupId;
 final String userGroup;
 final String imagePath;
 final String address;
 final String specialityId;
 final String speciality;
 final String designationId;
 final String designation;
 final String departmentId;
 final String department;
 final String districtId;
 final String district;
 final String divisionId;
 final String division;
 final String unitId;
 final String unit;
 final String subUnitId;
 final String subUnit;
 final String user;
 final String trainee;
 final String trainer;
 final String admin;
 final String userRoles;
 final String postLikes;
 final String id;
 final String userName;
 final String normalizedUserName;
 final String normalizedEmail;
 final bool emailConfirmed;
 final String passwordHash;
 final String securityStamp;
 final String concurrencyStamp;
 final String phoneNumber;
 final bool phoneNumberConfirmed;
 final bool twoFactorEnabled;
 final String lockoutEnd;
 final bool lockoutEnabled;
 final  int accessFailedCount;

  const ResultDataModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dateOfBirth,
    required this.dateOfJoining,
    required this.lastLogOn,
    required this.active,
    required this.deActivateOn,
    required this.gender,
    required this.userType,
    required this.loginType,
    required this.userGroupId,
    required this.userGroup,
    required this.imagePath,
    required this.address,
    required this.specialityId,
    required this.speciality,
    required this.designationId,
    required this.designation,
    required this.departmentId,
    required this.department,
    required this.districtId,
    required this.district,
    required this.divisionId,
    required this.division,
    required this.unitId,
    required this.unit,
    required this.subUnitId,
    required this.subUnit,
    required this.user,
    required this.trainee,
    required this.trainer,
    required this.admin,
    required this.userRoles,
    required this.postLikes,
    required this.id,
    required this.userName,
    required this.normalizedUserName,
    required this.normalizedEmail,
    required this.emailConfirmed,
    required this.passwordHash,
    required this.securityStamp,
    required this.concurrencyStamp,
    required this.phoneNumber,
    required this.phoneNumberConfirmed,
    required this.twoFactorEnabled,
    required this.lockoutEnd,
    required this.lockoutEnabled,
    required this.accessFailedCount,
  });

  factory ResultDataModel.fromJson(Map<String, dynamic> json) => ResultDataModel(
    firstName: json["FirstName"]??"",
    lastName: json["LastName"]??"",
    email: json["Email"]??"",
    dateOfBirth: json["DateOfBirth"]??"",
    dateOfJoining: json["DateOfJoining"]??"",
    lastLogOn: json["LastLogOn"]??"",
    active: json["Active"]??false,
    deActivateOn: json["DeActivateOn"]??"",
    gender: json["Gender"]??-1,
    userType: json["UserType"]??-1,
    loginType: json["LoginType"]??-1,
    userGroupId: json["UserGroupId"]??"",
    userGroup: json["UserGroup"]??"",
    imagePath: json["ImagePath"]??"",
    address: json["Address"]??"",
    specialityId: json["SpecialityId"]??"",
    speciality: json["Speciality"]??"",
    designationId: json["DesignationId"]??"",
    designation: json["Designation"]??"",
    departmentId: json["DepartmentId"]??"",
    department: json["Department"]??"",
    districtId: json["DistrictId"]??"",
    district: json["District"]??"",
    divisionId: json["DivisionId"]??"",
    division: json["Division"]??"",
    unitId: json["UnitId"]??"",
    unit: json["Unit"]??"",
    subUnitId: json["SubUnitId"]??"",
    subUnit: json["SubUnit"]??"",
    user: json["User"]??"",
    trainee: json["Trainee"]??"",
    trainer: json["Trainer"]??"",
    admin: json["Admin"]??"",
    userRoles: json["UserRoles"]??"",
    postLikes: json["PostLikes"]??"",
    id: json["Id"]??"",
    userName: json["UserName"]??"",
    normalizedUserName: json["NormalizedUserName"]??"",
    normalizedEmail: json["NormalizedEmail"??""],
    emailConfirmed: json["EmailConfirmed"]??false,
    passwordHash: json["PasswordHash"]??"",
    securityStamp: json["SecurityStamp"]??"",
    concurrencyStamp: json["ConcurrencyStamp"]??"",
    phoneNumber: json["PhoneNumber"]??"",
    phoneNumberConfirmed: json["PhoneNumberConfirmed"]??false,
    twoFactorEnabled: json["TwoFactorEnabled"]??false,
    lockoutEnd: json["LockoutEnd"]??"",
    lockoutEnabled: json["LockoutEnabled"]??false,
    accessFailedCount: json["AccessFailedCount"]??-1,
  );

  Map<String, dynamic> toJson() => {
    "FirstName": firstName,
    "LastName": lastName,
    "Email": email,
    "DateOfBirth": dateOfBirth,
    "DateOfJoining": dateOfJoining,
    "LastLogOn": lastLogOn,
    "Active": active,
    "DeActivateOn": deActivateOn,
    "Gender": gender,
    "UserType": userType,
    "LoginType": loginType,
    "UserGroupId": userGroupId,
    "UserGroup": userGroup,
    "ImagePath": imagePath,
    "Address": address,
    "SpecialityId": specialityId,
    "Speciality": speciality,
    "DesignationId": designationId,
    "Designation": designation,
    "DepartmentId": departmentId,
    "Department": department,
    "DistrictId": districtId,
    "District": district,
    "DivisionId": divisionId,
    "Division": division,
    "UnitId": unitId,
    "Unit": unit,
    "SubUnitId": subUnitId,
    "SubUnit": subUnit,
    "User": user,
    "Trainee": trainee,
    "Trainer": trainer,
    "Admin": admin,
    "UserRoles": userRoles,
    "PostLikes": postLikes,
    "Id": id,
    "UserName": userName,
    "NormalizedUserName": normalizedUserName,
    "NormalizedEmail": normalizedEmail,
    "EmailConfirmed": emailConfirmed,
    "PasswordHash": passwordHash,
    "SecurityStamp": securityStamp,
    "ConcurrencyStamp": concurrencyStamp,
    "PhoneNumber": phoneNumber,
    "PhoneNumberConfirmed": phoneNumberConfirmed,
    "TwoFactorEnabled": twoFactorEnabled,
    "LockoutEnd": lockoutEnd,
    "LockoutEnabled": lockoutEnabled,
    "AccessFailedCount": accessFailedCount,
  };
}