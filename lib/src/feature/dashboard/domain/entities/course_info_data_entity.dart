import 'package:adb_mobile/src/feature/dashboard/domain/entities/trainee_course_data_entity.dart';

class CourseInfoDataEntity {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final String enrollmentDate;
  final TraineeCourseDataEntity? traineeCourseDataEntity;
  final int noOfContents;
  final int noOfContentsStudied;
  final double rating;
  final int noOfRating;
  final double progress;

  CourseInfoDataEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.enrollmentDate,
    required this.traineeCourseDataEntity,
    required this.noOfContents,
    required this.noOfContentsStudied,
    required this.rating,
    required this.noOfRating,
    required this.progress,
  });
}
