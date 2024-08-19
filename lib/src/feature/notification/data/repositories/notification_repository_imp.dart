import '../mapper/notification_data_mapper.dart';
import '../models/notification_data_model.dart';
import '../../domain/entities/notification_data_entity.dart';
import '../../domain/repositories/notification_repository.dart';

import '../../../shared/data/mapper/response_mapper.dart';
import '../../../shared/data/models/response_model.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../data_sources/remote/notification_remote_data_source.dart';

class NotificationRepositoryImp extends NotificationRepository {
  final NotificationRemoteDataSource notificationRemoteDataSource;

  NotificationRepositoryImp({required this.notificationRemoteDataSource});

  @override
  Future<ResponseEntity> notificationInformation(String userId) async {
    ResponseModel responseModel =
        (await notificationRemoteDataSource.getNotification(userId));
    return ResponseModelToEntityMapper<List<NotificationDataEntity>,
            List<NotificationDataModel>>()
        .toEntityFromModel(
            responseModel,
            (List<NotificationDataModel> models) =>
                List<NotificationDataModel>.from(models)
                    .map((e) => e.toNotificationDataEntity)
                    .toList());
  }
}
