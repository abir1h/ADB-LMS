import 'package:adb_mobile/src/feature/faq/data/data_sources/remote/faq_remote_data_source.dart';
import 'package:adb_mobile/src/feature/faq/data/repositories/faq_repository_imp.dart';
import 'package:adb_mobile/src/feature/faq/domain/entities/faq_data_entity.dart';
import 'package:adb_mobile/src/feature/faq/domain/use_cases/faq_use_case.dart';


import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/config/local_storage_services.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../shared/domain/entities/response_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
}

mixin CourseConductFaqScreenService implements _ViewModel {
  late _ViewModel _view;
  final FaqUseCase _faqUseCase = FaqUseCase(
    FaqRepository:
        FaqRepositoryImp(faqRemoteDataSource: FaqRemoteDataSourceImp()),
  );

  Future<ResponseEntity> getFaqList(
      String userId, String courseId, String topicId) async {
    return _faqUseCase.faqCourseUseCase(userId, courseId, topicId);
  }

  ///Service configurations

  ///Stream controllers

  final AppStreamController<List<FaqDataEntity>> faqStreamController =
      AppStreamController();

  void loadFaq(String courseId, String topicId) async {
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    String? userId = localStorageService.getStringValue(StringData.userId);
    faqStreamController.add(LoadingState());
    getFaqList(userId!, courseId, topicId).then((value) {
      print(value);
      if (value.data != null) {
        faqStreamController
            .add(DataLoadedState<List<FaqDataEntity>>(value.data));
      } else if (value.data != null && value.data.isEmpty) {
        faqStreamController.add(EmptyState(message: "No FAQ Found!!"));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }
}
