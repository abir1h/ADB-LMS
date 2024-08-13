import '../../../shared/domain/entities/response_entity.dart';

abstract class FaqRepository {
  Future<ResponseEntity> faqInformation(String userId,String courseId);
}
