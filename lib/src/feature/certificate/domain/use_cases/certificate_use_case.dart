import 'package:adb_mobile/src/feature/certificate/domain/repositories/certificate_repository.dart';

import '../../../shared/domain/entities/response_entity.dart';

class CertificateUseCase {
  final CertificateRepository _certificateRepository;
  CertificateUseCase({required CertificateRepository certificateRepository})
      : _certificateRepository = certificateRepository;

  Future<ResponseEntity> certificateInformationUseCase(String userId) async {
    final response = _certificateRepository.certificateInformation(userId);
    return response;
  }
}
