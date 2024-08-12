import 'package:adb_mobile/src/feature/course/domain/entities/topic_data_entity.dart';

class CourseOverViewDataEntity {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final int expiryMonth;
  final int noOfRating;
  final double rating;
  final String code;
  final List<TopicDataEntity> topics;
  final bool bookmarked;
  final int progress;
  final bool enrollment;
  final bool isManager;
  final bool certificateAchieved;
  final bool courseTestCompleted;

  CourseOverViewDataEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.expiryMonth,
    required this.noOfRating,
    required this.rating,
    required this.code,
    required this.topics,
    required this.bookmarked,
    required this.progress,
    required this.enrollment,
    required this.isManager,
    required this.certificateAchieved,
    required this.courseTestCompleted,
  });}