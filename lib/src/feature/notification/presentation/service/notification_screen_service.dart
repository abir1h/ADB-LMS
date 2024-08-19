import 'package:adb_mobile/src/feature/faq/data/data_sources/remote/faq_remote_data_source.dart';
import 'package:adb_mobile/src/feature/faq/data/repositories/faq_repository_imp.dart';
import 'package:adb_mobile/src/feature/faq/domain/entities/faq_data_entity.dart';
import 'package:adb_mobile/src/feature/faq/domain/use_cases/faq_use_case.dart';
import 'package:adb_mobile/src/feature/notification/data/data_sources/remote/notification_remote_data_source.dart';
import 'package:adb_mobile/src/feature/notification/data/repositories/notification_repository_imp.dart';
import 'package:adb_mobile/src/feature/notification/domain/entities/notification_item_data_entity.dart';
import 'package:adb_mobile/src/feature/notification/domain/use_cases/faq_use_case.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/config/local_storage_services.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../shared/domain/entities/response_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
}

mixin NotificationScreenService implements _ViewModel {
  late _ViewModel _view;
  final NotificationUseCase _notificationUseCase = NotificationUseCase(
    notificationrepository:
        NotificationRepositoryImp(notificationRemoteDataSource: NotificationRemoteDataSourceImp()),
  );

  Future<ResponseEntity> getFaqList(String userId) async {
    return _notificationUseCase.notificationUseCase(userId);
  }

  ///Service configurations


  ///Stream controllers

  final AppStreamController<List<NotificationItemDataEntity>> notificationStreamController =
      AppStreamController();

  void loadNotification() async {
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    String? userId = localStorageService.getStringValue(StringData.userId);
    notificationStreamController.add(LoadingState());
    getFaqList(userId!).then((value) {
      print(value);
      if (value.data != null) {
        notificationStreamController
            .add(DataLoadedState<List<NotificationItemDataEntity>>(value.data));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }
}
