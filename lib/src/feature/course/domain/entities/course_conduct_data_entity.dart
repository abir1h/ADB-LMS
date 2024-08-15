import 'topic_entity.dart';

import 'course_entity.dart';
import 'material_entity.dart';

class CourseConductDataEntity {
  final CourseEntity? course;
  final TopicEntity? topic;
  final int progress;
  final List<MaterialEntity>? materials;

  const CourseConductDataEntity({
    required this.course,
    required this.topic,
    required this.progress,
    required this.materials,
  });
}
