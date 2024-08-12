import 'package:adb_mobile/src/feature/course/domain/entities/resource_data_entity.dart';

class MaterialDataEntity {
  final String id;
  final String title;
  final String filePath;
  final int fileType;
  final double fileSizeKb;
  final double requiredStudyTimeSec;
  final String type;
  final List<ResourceDataEntity>? resources;
  final int dependencies;
  final double progress;

  const MaterialDataEntity({
    required this.id,
    required this.title,
    required this.filePath,
    required this.fileType,
    required this.fileSizeKb,
    required this.requiredStudyTimeSec,
    required this.type,
    required this.resources,
    required this.dependencies,
    required this.progress,
  });}