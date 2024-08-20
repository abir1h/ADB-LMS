import 'package:adb_mobile/src/feature/faq/data/mapper/faq_data_mapper.dart';
import 'package:adb_mobile/src/feature/faq/data/models/faq_data_model.dart';
import 'package:adb_mobile/src/feature/faq/domain/entities/faq_data_entity.dart';
import 'package:adb_mobile/src/feature/faq/domain/repositories/faq_repository.dart';

import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/data/models/response_model.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../data_sources/remote/faq_remote_data_source.dart';

class FaqRepositoryImp extends FaqRepository {
  final FaqRemoteDataSource faqRemoteDataSource;
  FaqRepositoryImp({required this.faqRemoteDataSource});

  @override
  Future<ResponseEntity> faqInformation(String userId, String courseId) async {
    ResponseModel responseModel =
        (await faqRemoteDataSource.getFaqAction(userId, courseId));
    return ResponseModelToEntityMapper<List<FaqDataEntity>,
        List<FaqDataModel>>()
        .toEntityFromModel(
        responseModel,
            (List<FaqDataModel> models) => List<FaqDataModel>.from(models)
            .map((e) => e.toFaqDataEntity)
            .toList());
  } @override
  Future<ResponseEntity> faqCourseInformation(String userId, String courseId,String topicId) async {
    ResponseModel responseModel =
        (await faqRemoteDataSource.getCourseFaq(userId, courseId,topicId));
    return ResponseModelToEntityMapper<List<FaqDataEntity>,
        List<FaqDataModel>>()
        .toEntityFromModel(
        responseModel,
            (List<FaqDataModel> models) => List<FaqDataModel>.from(models)
            .map((e) => e.toFaqDataEntity)
            .toList());
  }
}
