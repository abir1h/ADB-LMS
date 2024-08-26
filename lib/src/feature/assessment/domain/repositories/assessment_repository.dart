import '../entities/exam_result_data_entity.dart';
import '../entities/mcq_data_entity.dart';
import '../../../shared/domain/entities/response_entity.dart';

abstract class AssessmentRepository {
  Future<ResponseEntity> getExamInfo(String materialId, String userId);
  Future<List<McqDataEntity>> getQuestions(String materialId, String userId);
  Future<List<ExamResultDataEntity>> getExamResults(String materialId, String userId);
}
