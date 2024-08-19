import 'package:adb_mobile/src/feature/authentication/domain/entities/institute_data_entity.dart';

class InstituteListDataEntity {
  final List<InstituteDataEntity> data;
  final String message;
  final int status;

  InstituteListDataEntity({
    required this.data,
    required this.message,
    required this.status,
  });}