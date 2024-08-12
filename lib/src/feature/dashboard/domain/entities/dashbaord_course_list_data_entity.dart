import 'package:adb_mobile/src/feature/dashboard/domain/entities/course_info_data_entity.dart';

class DashboardCourseListDataEntity {
  final List<CourseInfoDataEntity> data;
  final String key;

  DashboardCourseListDataEntity({
    required this.data,
    required this.key,
  });
}
