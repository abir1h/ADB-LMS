import '../mapper/mcq_data_mapper.dart';
import '../models/mcq_data_model.dart';
import '../../domain/entities/mcq_data_entity.dart';
import '../data_sources/remote/assessment_data_source.dart';
import '../mapper/exam_info_data_mapper.dart';
import '../models/exam_info_data_model.dart';
import '../../domain/entities/exam_info_data_entity.dart';
import '../../domain/repositories/assessment_repository.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/data/models/response_model.dart';

class AssessmentRepositoryImp extends AssessmentRepository {
  final AssessmentDataSource assessmentDataSource;
  AssessmentRepositoryImp({required this.assessmentDataSource});

  @override
  Future<ResponseEntity> getExamInfo(String materialId, String userId) async {
    ResponseModel responseModel =
        (await assessmentDataSource.getExamInfoAction(materialId, userId));
    return ResponseModelToEntityMapper<ExamInfoDataEntity, ExamInfoDataModel>()
        .toEntityFromModel(responseModel,
            (ExamInfoDataModel model) => model.toExamInfoDataEntity);
  }

  @override
  Future<List<McqDataEntity>> getQuestions(
      String materialId, String userId) async {
    List<McqDataModel> mcqDataModelList =
        (await assessmentDataSource.getQuestionsAction(materialId, userId));
    return List<McqDataModel>.from(mcqDataModelList)
        .map((e) => e.toMcqDataEntity)
        .toList();
  }
}
