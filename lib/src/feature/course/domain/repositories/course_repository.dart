import '../../../shared/domain/entities/response_entity.dart';

abstract class CourseRepository {
  Future<ResponseEntity> courseInformation(String userId);
  Future<ResponseEntity> courseOverViewInformation(String userId,String courseId);
}
