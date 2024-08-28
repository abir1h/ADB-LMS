import 'trainee_user_data_model.dart';
import 'package:flutter/cupertino.dart';

@immutable
class UserDataModel {
  final String firstName;
  final String lastName;
  final String fullName;
  final String email;
  final String userName;
  final String phoneNumber;
  final String address;
  final String workLocation;
  final String lineManagerName;
  final String lineManagerPin;
  final bool active;
  final String gender;
  final String designation;
  final String division;
  final String department;
  final String unit;
  final String subUnit;
  final String dateOfBirth;
  final String dateOfJoining;
  final String position;
  final TraineeUserDataModel? traineeUser;
  final String imagePath;

  const UserDataModel({
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.email,
    required this.userName,
    required this.phoneNumber,
    required this.address,
    required this.workLocation,
    required this.lineManagerName,
    required this.lineManagerPin,
    required this.active,
    required this.gender,
    required this.designation,
    required this.division,
    required this.department,
    required this.unit,
    required this.subUnit,
    required this.dateOfBirth,
    required this.dateOfJoining,
    required this.position,
    required this.traineeUser,
    required this.imagePath,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
    firstName: json["FirstName"]??"",
    lastName: json["LastName"]??"",
    fullName: json["FullName"]??"",
    email: json["Email"]??"",
    userName: json["UserName"]??"",
    phoneNumber: json["PhoneNumber"]??"",
    address: json["Address"]??"",
    workLocation: json["WorkLocation"]??"",
    lineManagerName: json["LineManagerName"]??"",
    lineManagerPin: json["LineManagerPIN"]??"",
    active: json["Active"]??false,
    gender: json["Gender"]??"",
    designation: json["Designation"]??"",
    division: json["Division"]??"",
    department: json["Department"]??"",
    unit: json["Unit"]??"",
    subUnit: json["SubUnit"]??"",
    dateOfBirth:json["DateOfBirth"]??"",
    dateOfJoining:json["DateOfJoining"]??"",
    position: json["Position"] ?? "",
    traineeUser: json['TraineeUser'] != null
        ? TraineeUserDataModel.fromJson(json['TraineeUser'])
        : null,
    imagePath: json["ImagePath"]??"",
  );

  Map<String, dynamic> toJson() => {
    "FirstName": firstName,
    "LastName": lastName,
    "FullName": fullName,
    "Email": email,
    "UserName": userName,
    "PhoneNumber": phoneNumber,
    "Address": address,
    "WorkLocation": workLocation,
    "LineManagerName": lineManagerName,
    "LineManagerPIN": lineManagerPin,
    "Active": active,
    "Gender": gender,
    "Designation": designation,
    "Division": division,
    "Department": department,
    "Unit": unit,
    "SubUnit": subUnit,
    "DateOfBirth": dateOfBirth,
    "DateOfJoining": dateOfJoining,
    "Position": position,
    "TraineeUser": traineeUser?.toJson(),
    "ImagePath": imagePath,
  };
}


