import '../../../shared/domain/entities/response_entity.dart';
import '../repositories/discussion_repository.dart';

class DiscussionUseCase {
  final DiscussionRepository _discussionRepository;
  DiscussionUseCase({required DiscussionRepository discussionRepository})
      : _discussionRepository = discussionRepository;

  Future<ResponseEntity> discussionInformationUseCase(
      String userId, String courseId) async {
    final response =
        _discussionRepository.discussionInformation(userId, courseId);
    return response;
  }

  Future<ResponseEntity> discussionVideoDropDownInformationUseCase(
      String userId, String courseId, String type, String topicId) async {
    final response = _discussionRepository.discussionVideoDropdownInformation(
        userId, courseId, type, topicId);
    return response;
  }
}
