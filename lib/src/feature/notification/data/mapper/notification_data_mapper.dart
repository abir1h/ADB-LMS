import 'notification_item_data_mapper.dart';
import '../models/notification_item_data_model.dart';

import '../../domain/entities/notification_data_entity.dart';
import '../../domain/entities/notification_item_data_entity.dart';
import '../models/notification_data_model.dart';

abstract class NotificationDataMapper<M, E> {
  M fromEntityToModel(E entity);

  E toEntityFromModel(M model);
}

class _NotificationDataModelToEntityMapper extends NotificationDataMapper<
    NotificationDataModel, NotificationDataEntity> {
  @override
  NotificationDataModel fromEntityToModel(NotificationDataEntity entity) {
    return NotificationDataModel(
        records: List<NotificationItemDataEntity>.from(entity.records)
            .map((entity) => entity.toNotificationItemDataModel)
            .toList(),
        total: entity.total,
        unseenTotal: entity.unseenTotal);
  }

  @override
  NotificationDataEntity toEntityFromModel(NotificationDataModel model) {
    return NotificationDataEntity(
        records: List<NotificationItemDataModel>.from(model.records)
            .map((model) => model.toNotificationItemDataEntity)
            .toList(),
        total: model.total,
        unseenTotal: model.unseenTotal);
  }
}

extension NotificationDataModelExt on NotificationDataModel {
  NotificationDataEntity get toNotificationDataEntity =>
      _NotificationDataModelToEntityMapper().toEntityFromModel(this);
}

extension NotificationDataEntityExt on NotificationDataEntity {
  NotificationDataModel get toNotificationDataModel =>
      _NotificationDataModelToEntityMapper().fromEntityToModel(this);
}
