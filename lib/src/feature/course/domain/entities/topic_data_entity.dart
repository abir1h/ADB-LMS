import 'package:adb_mobile/src/feature/course/domain/entities/material_data_entity.dart';

class TopicDataEntity {
  final String id;
  final String title;
  final List<MaterialDataEntity> materials;
  final int progressSum;
  final int materialCount;
  final int progress;
  final bool testsCompleted;

  const TopicDataEntity({
    required this.id,
    required this.title,
    required this.materials,
    required this.progressSum,
    required this.materialCount,
    required this.progress,
    required this.testsCompleted,
  });
}