import '../../domain/entities/notification_item_data_entity.dart';
import '../models/notification_item_data_model.dart';

abstract class NotificationItemDataMapper<M, E> {
  M fromEntityToModel(E entity);

  E toEntityFromModel(M model);
}

class _NotificationItemDataModelToEntityMapper
    extends NotificationItemDataMapper<NotificationItemDataModel,
        NotificationItemDataEntity> {
  @override
  NotificationItemDataModel fromEntityToModel(
      NotificationItemDataEntity entity) {
    return NotificationItemDataModel(
        id: entity.id,
        title: entity.title,
        details: entity.details,
        createdOn: entity.createdOn,
        creatorName: entity.creatorName,
        creatorEmail: entity.creatorEmail,
        creatorPhoneNumber: entity.creatorPhoneNumber,
        notificationType: entity.notificationType,
        payload: entity.payload,
        navigateTo: entity.navigateTo,
        seen: entity.seen);
  }

  @override
  NotificationItemDataEntity toEntityFromModel(
      NotificationItemDataModel model) {
    return NotificationItemDataEntity(
        id: model.id,
        title: model.title,
        details: model.details,
        createdOn: model.createdOn,
        creatorName: model.creatorName,
        creatorEmail: model.creatorEmail,
        creatorPhoneNumber: model.creatorPhoneNumber,
        notificationType: model.notificationType,
        payload: model.payload,
        navigateTo: model.navigateTo,
        seen: model.seen);
  }
}

extension NotificationItemDataModelExt on NotificationItemDataModel {
  NotificationItemDataEntity get toNotificationItemDataEntity =>
      _NotificationItemDataModelToEntityMapper().toEntityFromModel(this);
}

extension NotificationItemDataEntityExt on NotificationItemDataEntity {
  NotificationItemDataModel get toNotificationItemDataModel =>
      _NotificationItemDataModelToEntityMapper().fromEntityToModel(this);
}
