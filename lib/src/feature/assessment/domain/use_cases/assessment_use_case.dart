import '../entities/mcq_data_entity.dart';
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

  Future<List<McqDataEntity>> getQuestionsUseCase(
      String materialId, String userId) async {
    final response = _assessmentRepository.getQuestions(materialId, userId);
    return response;
  }

  Future<ResponseEntity> submitExamUseCase(
      String userId,
      String examId,
      String startTime,
      String endTime,
      bool autoSubmission,
      int testType,
      List<McqDataEntity> mcqData) async {
    final response = _assessmentRepository.submitExam(
        userId, examId, startTime, endTime, autoSubmission, testType, mcqData);
    return response;
  }
}
