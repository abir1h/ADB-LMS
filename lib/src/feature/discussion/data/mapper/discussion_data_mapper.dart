import '../../domain/entities/discussion_data_entity.dart';
import '../models/discussion_data_model.dart';

abstract class DiscussionDataMapper<M, E> {
  M fromEntityToModel(E entity);
  E toEntityFromModel(M model);
}

class _DiscussionDataModelToEntityMapper
    extends DiscussionDataMapper<DiscussionDataModel, DiscussionDataEntity> {
  @override
  DiscussionDataModel fromEntityToModel(DiscussionDataEntity entity) {
    return DiscussionDataModel(
        id: entity.id,
        disscussionType: entity.disscussionType,
        material: entity.material,
        exam: entity.exam,
        mockTest: entity.mockTest,
        comment: entity.comment,
        commentatorType: entity.commentatorType,
        commentTime: entity.commentTime,
        isSelfComment: entity.isSelfComment,
        email: entity.email,
        phoneNumber: entity.phoneNumber,
        imagePath: entity.imagePath,
        commenterName: entity.commenterName);
  }

  @override
  DiscussionDataEntity toEntityFromModel(DiscussionDataModel model) {
    return DiscussionDataEntity(
        id: model.id,
        disscussionType: model.disscussionType,
        material: model.material,
        exam: model.exam,
        mockTest: model.mockTest,
        comment: model.comment,
        commentatorType: model.commentatorType,
        commentTime: model.commentTime,
        isSelfComment: model.isSelfComment,
        email: model.email,
        phoneNumber: model.phoneNumber,
        imagePath: model.imagePath,
        commenterName: model.commenterName);
  }
}

extension DiscussionDataModelExt on DiscussionDataModel {
  DiscussionDataEntity get toDiscussionDataEntity =>
      _DiscussionDataModelToEntityMapper().toEntityFromModel(this);
}

extension DiscussionDataEntityExt on DiscussionDataEntity {
  DiscussionDataModel get toDiscussionDataModel =>
      _DiscussionDataModelToEntityMapper().fromEntityToModel(this);
}
