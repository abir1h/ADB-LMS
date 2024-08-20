import '../../../shared/domain/entities/response_entity.dart';
import '../repositories/faq_repository.dart';

class FaqUseCase {
  final FaqRepository _FaqRepository;
  FaqUseCase({required FaqRepository FaqRepository})
      : _FaqRepository = FaqRepository;

  Future<ResponseEntity> faqUseCase(String userId, String courseId) async {
    final response = _FaqRepository.faqInformation(userId, courseId);
    return response;
  }

  Future<ResponseEntity> faqCourseUseCase(
      String userId, String courseId, String topicId) async {
    final response =
        _FaqRepository.faqCourseInformation(userId, courseId, topicId);
    return response;
  }
}
