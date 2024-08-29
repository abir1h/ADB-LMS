import 'package:adb_mobile/src/feature/authentication/domain/entities/district_info_data_entity.dart';

class DistrictDropDownDataEntity {
  final List<DistrictInfoDataEntity> data;
  final dynamic message;
  final int status;

  const DistrictDropDownDataEntity({
    required this.data,
    required this.message,
    required this.status,
  });
}