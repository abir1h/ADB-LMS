import '../mapper/course_conduct_mapper.dart';
import '../models/course_conduct_data_model.dart';
import '../../domain/entities/course_conduct_data_entity.dart';
import '../mapper/cource_overview_data_mapper.dart';
import '../mapper/course_list_data_mapper.dart';
import '../models/course_over_view_data_model.dart';
import '../../domain/entities/course_overview_data_entity.dart';
import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/data/models/response_model.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../domain/entities/course_list_data_entity.dart';
import '../../domain/repositories/course_repository.dart';
import '../data_sources/remote/course_data_source.dart';
import '../models/course_list_data_model.dart';

class CourseRepositoryImp extends CourseRepository {
  final CourseRemoteDataSource courseRemoteDataSource;
  CourseRepositoryImp({required this.courseRemoteDataSource});

  @override
  Future<ResponseEntity> courseInformation(String userId) async {
    ResponseModel responseModel =
        (await courseRemoteDataSource.getCourseAction(userId));
    return ResponseModelToEntityMapper<CourseListDataEntity,
            CourseListDataModel>()
        .toEntityFromModel(responseModel,
            (CourseListDataModel model) => model.toCourseListDataEntity);
  }

  @override
  Future<ResponseEntity> courseOverViewInformation(
      String userId, String courseId) async {
    ResponseModel responseModel = (await courseRemoteDataSource
        .getCourseOverViewAction(userId, courseId));
    return ResponseModelToEntityMapper<CourseOverViewDataEntity,
            CourseOverViewDataModel>()
        .toEntityFromModel(
            responseModel,
            (CourseOverViewDataModel model) =>
                model.toCourseOverViewDataEntity);
  }

  @override
  Future<ResponseEntity> courseTopicDetails(
      String userId, String courseId, String topicId) async {
    ResponseModel responseModel = (await courseRemoteDataSource
        .getCourseTopicDetailsAction(userId, courseId, topicId));
    return ResponseModelToEntityMapper<CourseConductDataEntity,
            CourseConductDataModel>()
        .toEntityFromModel(responseModel,
            (CourseConductDataModel model) => model.toCourseConductDataEntity);
  }

  @override
  Future<ResponseEntity> contentStudy(
      String userId, String materialId, int studyTimeSec) async {
    ResponseModel responseModel = (await courseRemoteDataSource
        .contentStudyAction(userId, materialId, studyTimeSec));
    return ResponseEntity(
        message: responseModel.message,
        error: responseModel.error,
        status: responseModel.status,
        data: responseModel.data);
  }
}
