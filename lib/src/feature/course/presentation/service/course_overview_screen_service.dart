import 'package:adb_mobile/src/feature/course/domain/entities/course_overview_data_entity.dart';

import '../../../../core/routes/app_route_args.dart';
import '../../data/data_sources/remote/course_data_source.dart';
import '../../data/repositories/course_repository_imp.dart';
import '../../domain/use_cases/course_use_case.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/config/local_storage_services.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../shared/domain/entities/response_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
}

mixin CourseOverViewScreenService implements _ViewModel {
  late _ViewModel _view;
  CourseDetailsScreenArgs? _courseDetailsScreenArgs;

  final CourseUseCase _courseUseCase = CourseUseCase(
    courseRepository: CourseRepositoryImp(
        courseRemoteDataSource: CourseRemoteDataSourceImp()),
  );


  Future<ResponseEntity> getCourseOverView(
      String userId, String courseId) async {
    return _courseUseCase.courseOverViewInformationUseCase(userId, courseId);
  }

  ///Service configurations
  @override
  void initState() {
    // loadCourses(_courseDetailsScreenArgs!.data!.id);

    _view = this;
  }

  ///Stream controllers

  final AppStreamController<CourseOverViewDataEntity> courseStreamController =
  AppStreamController();

  void loadCourses(String courseId) async {
    print(courseId);
    LocalStorageService localStorageService =
    await LocalStorageService.getInstance();
    String? userId = localStorageService.getStringValue(StringData.userId);
    courseStreamController.add(LoadingState());
    getCourseOverView(userId!,courseId).then((value) {
      print(value);
      if (value.data != null) {
        courseStreamController
            .add(DataLoadedState<CourseOverViewDataEntity>(value.data));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }
}
