import '../../../shared/domain/entities/response_entity.dart';

abstract class DiscussionRepository {
  Future<ResponseEntity> discussionInformation(String userId,String courseId);
  Future<ResponseEntity> discussionVideoDropdownInformation(String userId, String courseId, String type, String topicId);
}
