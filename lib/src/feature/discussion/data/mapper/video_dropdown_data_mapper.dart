import '../../domain/entities/video_dropdown_data_entity.dart';
import '../models/video_dropdown_data_model.dart';

abstract class VideoDropdownDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _VideoDropdownDataModelToEntityMapper extends VideoDropdownDataMapper<
    VideoDropdownDataModel, VideoDropdownDataEntity> {
  @override
  VideoDropdownDataModel fromEntityToModel(VideoDropdownDataEntity entity) {
    return VideoDropdownDataModel(id: entity.id, title: entity.title);
  }

  @override
  VideoDropdownDataEntity toEntityFromModel(VideoDropdownDataModel model) {
    return VideoDropdownDataEntity(id: model.id, title: model.title);
  }
}

extension VideoDropdownDataModelExt on VideoDropdownDataModel {
  VideoDropdownDataEntity get toVideoDropdownDataEntity =>
      _VideoDropdownDataModelToEntityMapper().toEntityFromModel(this);
}

extension VideoDropdownDataEntityExt on VideoDropdownDataEntity {
  VideoDropdownDataModel get toVideoDropdownDataModel =>
      _VideoDropdownDataModelToEntityMapper().fromEntityToModel(this);
}
