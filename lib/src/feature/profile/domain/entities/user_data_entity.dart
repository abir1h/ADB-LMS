import 'package:adb_mobile/src/feature/profile/domain/entities/trainee_user_data_entity.dart';

class UserDataEntity {
  String firstName;
  String lastName;
  String fullName;
  String email;
  String userName;
  String phoneNumber;
  String address;
  String workLocation;
  String lineManagerName;
  String lineManagerPin;
  bool active;
  String gender;
  String designation;
  String division;
  String department;
  String unit;
  String subUnit;
  String dateOfBirth;
  String dateOfJoining;
  String position;
  TraineeUserDataEntity? traineeUser;
  String imagePath;

  UserDataEntity({
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
  });}