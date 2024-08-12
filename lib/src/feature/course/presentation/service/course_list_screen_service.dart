import '../../data/data_sources/remote/course_data_source.dart';
import '../../data/repositories/course_repository_imp.dart';
import '../../domain/use_cases/course_use_case.dart';
import '../../../dashboard/domain/entities/course_info_data_entity.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/config/local_storage_services.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../shared/domain/entities/response_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
}

mixin CourseListScreenService implements _ViewModel {
  late _ViewModel _view;
  final CourseUseCase _courseUseCase = CourseUseCase(
    courseRepository: CourseRepositoryImp(
        courseRemoteDataSource: CourseRemoteDataSourceImp()),
  );

  Future<ResponseEntity> getCourseList(String userId) async {
    return _courseUseCase.courseInformationUseCase(userId);
  }

  Future<ResponseEntity> getCourseOverView(
      String userId, String courseId) async {
    return _courseUseCase.courseOverViewInformationUseCase(userId, courseId);
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    _loadCourses();
  }

  ///Stream controllers

  final AppStreamController<List<CourseInfoDataEntity>> courseStreamController =
      AppStreamController();

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
      } else {
        _view.showWarning(value.message!);
      }
    });
  }
}
