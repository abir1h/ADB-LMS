import '../../../shared/domain/entities/response_entity.dart';
import '../repositories/notification_repository.dart';

class NotificationUseCase {
  final NotificationRepository _notificationRepository;
  NotificationUseCase({required NotificationRepository notificationrepository})
      : _notificationRepository = notificationrepository;

  Future<ResponseEntity> notificationUseCase(String userId) async {
    final response = _notificationRepository.notificationInformation(userId);
    return response;
  }
}
