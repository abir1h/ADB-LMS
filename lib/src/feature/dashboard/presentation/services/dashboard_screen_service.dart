import 'package:adb_mobile/src/feature/dashboard/domain/entities/course_info_data_entity.dart';

import '../../data/data_sources/remote/trainee_count_data_source.dart';
import '../../data/repositories/trainee_count_repository_imp.dart';
import '../../domain/entities/trainee_count_data_entity.dart';
import '../../domain/use_cases/trainee_count_use_case.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/config/local_storage_services.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../shared/domain/entities/response_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void navigateToLandingScreen();
}

mixin DashboardScreenService implements _ViewModel {
  late _ViewModel _view;
  final TraineeCountUseCase _traineeCountUseCase = TraineeCountUseCase(
    traineeCountRepository: TraineeCountRepositoryImp(
        traineeCountRemoteDataSource: TraineeCountRemoteDataSourceImp()),
  );

  Future<ResponseEntity> getProfileInformation(String userId) async {
    return _traineeCountUseCase.traineeCountInformationUseCase(userId);
  }

  Future<ResponseEntity> getCourseList(String userId) async {
    return _traineeCountUseCase.traineeCourseInformationUseCase(userId);
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    _loadTraineeCountData();
    _loadCourses();
  }

  ///Stream controllers
  final AppStreamController<TraineeCountDataEntity>
      traineeCountStreamController = AppStreamController();
  final AppStreamController<List<CourseInfoDataEntity>> courseStreamController =
      AppStreamController();

  ///Load Category list
  void _loadTraineeCountData() async {
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    String? userId = localStorageService.getStringValue(StringData.userId);
    traineeCountStreamController.add(LoadingState());
    getProfileInformation(userId!).then((value) {
      print(value);
      if (value.data != null) {
        traineeCountStreamController
            .add(DataLoadedState<TraineeCountDataEntity>(value.data));
      } else if (value.error != null) {
        //Navigate to landing
        _view.navigateToLandingScreen();
      } else if (value.error == null && value.data == null) {
        traineeCountStreamController.add(EmptyState(message: 'No Data Found'));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  void _loadCourses() async {
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    String? userId = localStorageService.getStringValue(StringData.userId);
    courseStreamController.add(LoadingState());
    getCourseList(userId!).then((value) {
      print(value);
      if (value.data != null) {
        courseStreamController
            .add(DataLoadedState<List<CourseInfoDataEntity>>(value.data.data));
      } else if (value.error != null) {
        //Navigate to landing
        _view.navigateToLandingScreen();
      } else {
        _view.showWarning(value.message!);
      }
    });
  }
}
