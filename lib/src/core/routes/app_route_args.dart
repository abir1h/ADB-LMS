import '../../feature/course/domain/entities/course_overview_data_entity.dart';
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

class BaseScreenArgs {
  final int index;
  BaseScreenArgs({required this.index});
}
class CertificateViewScreenArgs {
  final String data;
  CertificateViewScreenArgs({required this.data});
}
