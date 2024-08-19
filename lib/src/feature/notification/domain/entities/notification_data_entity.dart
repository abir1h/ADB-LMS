import 'notification_item_data_entity.dart';

class NotificationDataEntity {
  final List<NotificationItemDataEntity> records;
  final int total;
  final int unseenTotal;

  const NotificationDataEntity({
    required this.records,
    required this.total,
    required this.unseenTotal,
  });
}
