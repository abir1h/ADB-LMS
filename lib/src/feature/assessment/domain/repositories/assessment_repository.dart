import '../entities/mcq_data_entity.dart';
import '../../../shared/domain/entities/response_entity.dart';

abstract class AssessmentRepository {
  Future<ResponseEntity> getExamInfo(String materialId, String userId);
  Future<List<McqDataEntity>> getQuestions(String materialId, String userId);
}
