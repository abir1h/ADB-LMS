import 'popup_quiz_data_mapper.dart';
import 'resource_data_mapper.dart';
import '../models/material_model.dart';
import '../models/resource_data_model.dart';
import '../../domain/entities/material_entity.dart';
import '../../domain/entities/resource_data_entity.dart';
import '../../domain/entities/popup_quiz_data_model.dart';
import '../models/popup_quiz_data_model.dart';

abstract class MaterialMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _MaterialModelToEntityMapper
    extends MaterialMapper<MaterialModel, MaterialEntity> {
  @override
  MaterialModel fromEntityToModel(MaterialEntity entity) {
    return MaterialModel(
        id: entity.id,
        title: entity.title,
        type: entity.type,
        filePath: entity.filePath,
        s3Path: entity.s3Path,
        externalLink: entity.externalLink,
        youtubeId: entity.youtubeId,
        fileSizeKb: entity.fileSizeKb,
        videoDurationSecond: entity.videoDurationSecond,
        sequence: entity.sequence,
        studied: entity.studied,
        restricted: entity.restricted,
        lastStudyTimeSec: entity.lastStudyTimeSec,
        requiredStudyTimeSec: entity.requiredStudyTimeSec,
        canDownload: entity.canDownload,
        resources: List<ResourceDataEntity>.from(entity.resources)
            .map((entity) => entity.toResourceDataModel)
            .toList(),
        popupQuizzes: List<PopupQuizDataEntity>.from(entity.popupQuizzes)
            .map((entity) => entity.toPopupQuizDataModel)
            .toList(),
        isCompleted: entity.isCompleted,
        progress: entity.progress);
  }

  @override
  MaterialEntity toEntityFromModel(MaterialModel model) {
    return MaterialEntity(
        id: model.id,
        title: model.title,
        type: model.type,
        filePath: model.filePath,
        s3Path: model.s3Path,
        externalLink: model.externalLink,
        youtubeId: model.youtubeId,
        fileSizeKb: model.fileSizeKb,
        videoDurationSecond: model.videoDurationSecond,
        sequence: model.sequence,
        studied: model.studied,
        restricted: model.restricted,
        lastStudyTimeSec: model.lastStudyTimeSec,
        requiredStudyTimeSec: model.requiredStudyTimeSec,
        canDownload: model.canDownload,
        resources: List<ResourceDataModel>.from(model.resources)
            .map((model) => model.toResourceDataEntity)
            .toList(),
        popupQuizzes: List<PopupQuizDataModel>.from(model.popupQuizzes)
            .map((model) => model.toPopupQuizDataEntity)
            .toList(),
        isCompleted: model.isCompleted,
        progress: model.progress);
  }
}

extension MaterialModelExt on MaterialModel {
  MaterialEntity get toMaterialEntity =>
      _MaterialModelToEntityMapper().toEntityFromModel(this);
}

extension MaterialEntityExt on MaterialEntity {
  MaterialModel get toMaterialModel =>
      _MaterialModelToEntityMapper().fromEntityToModel(this);
}
