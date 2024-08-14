import 'package:adb_mobile/src/feature/certificate/domain/entities/certificate_data_entity.dart';

class CertificateListDataEntity {
  final List<CertificateDataEntity> data;
  final int total;

  const CertificateListDataEntity({
    required this.data,
    required this.total,
  });
}
