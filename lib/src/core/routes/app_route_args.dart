import '../../feature/assessment/domain/entities/exam_info_data_entity.dart';
import '../../feature/dashboard/domain/entities/course_info_data_entity.dart';

class CourseDetailsScreenArgs {
  final CourseInfoDataEntity? data;
  CourseDetailsScreenArgs({this.data});
}

class CourseConductScreenArgs {
  final String? courseId;
  final String? topicId;
  CourseConductScreenArgs({this.courseId, this.topicId});
}

class ExamInfoScreenArgs {
  final String materialId;
  final String examType;
  ExamInfoScreenArgs({required this.materialId, required this.examType});
}

class ExamScreenArgs {
  final ExamInfoDataEntity examInfoDataEntity;
  ExamScreenArgs({required this.examInfoDataEntity});
}

class BaseScreenArgs {
  final int index;
  BaseScreenArgs({required this.index});
}

class CertificateViewScreenArgs {
  final String data;
  CertificateViewScreenArgs({required this.data});
}
