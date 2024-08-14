import '../../../shared/domain/entities/response_entity.dart';

abstract class CertificateRepository {
  Future<ResponseEntity> certificateInformation(String userId);
}
