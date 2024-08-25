import '../repositories/assessment_repository.dart';
import '../../../shared/domain/entities/response_entity.dart';

class AssessmentUseCase {
  final AssessmentRepository _assessmentRepository;
  AssessmentUseCase({required AssessmentRepository assessmentRepository})
      : _assessmentRepository = assessmentRepository;

  Future<ResponseEntity> examInfoUseCase(
      String materialId, String userId) async {
    final response = _assessmentRepository.getExamInfo(materialId, userId);
    return response;
  }
}
