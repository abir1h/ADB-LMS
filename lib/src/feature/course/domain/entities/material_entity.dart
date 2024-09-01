import 'package:adb_mobile/src/feature/course/domain/entities/popup_quiz_data_model.dart';
import 'package:adb_mobile/src/feature/course/domain/entities/resource_data_entity.dart';

class MaterialEntity {
  final String id;
  final String title;
  final String type;
  final String filePath;
  final String s3Path;
  final String externalLink;
  final String youtubeId;
  final int fileSizeKb;
  final int videoDurationSecond;
  final int sequence;
  bool studied;
  bool restricted;
  final int lastStudyTimeSec;
  final int requiredStudyTimeSec;
  final bool canDownload;
  final List<ResourceDataEntity> resources;
  final List<PopupQuizDataEntity> popupQuizzes;
  final bool isCompleted;
  final double progress;

  MaterialEntity({
    required this.id,
    required this.title,
    required this.type,
    required this.filePath,
    required this.s3Path,
    required this.externalLink,
    required this.youtubeId,
    required this.fileSizeKb,
    required this.videoDurationSecond,
    required this.sequence,
    required this.studied,
    required this.restricted,
    required this.lastStudyTimeSec,
    required this.requiredStudyTimeSec,
    required this.canDownload,
    required this.resources,
    required this.popupQuizzes,
    required this.isCompleted,
    required this.progress,
  });
}
