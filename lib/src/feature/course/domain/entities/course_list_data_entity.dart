import 'package:adb_mobile/src/feature/dashboard/domain/entities/course_info_data_entity.dart';

class CourseListDataEntity {
  final List<CourseInfoDataEntity> data;
  final int total;

  const CourseListDataEntity({
    required this.data,
    required this.total,
  });
}