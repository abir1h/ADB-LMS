import '../repositories/course_repository.dart';
import '../../../shared/domain/entities/response_entity.dart';

class CourseUseCase {
  final CourseRepository _courseRepository;
  CourseUseCase({required CourseRepository courseRepository})
      : _courseRepository = courseRepository;

  Future<ResponseEntity> courseInformationUseCase(String userId) async {
    final response = _courseRepository.courseInformation(userId);
    return response;
  }

  Future<ResponseEntity> courseOverViewInformationUseCase(
      String userId, String courseId) async {
    final response =
        _courseRepository.courseOverViewInformation(userId, courseId);
    return response;
  }

  Future<ResponseEntity> courseTopicDetailsUseCase(
      String userId, String courseId, String topicId) async {
    final response =
        _courseRepository.courseTopicDetails(userId, courseId, topicId);
    return response;
  }
}
