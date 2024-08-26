import 'package:flutter/material.dart';

import '../../../../core/routes/app_route_args.dart';
import '../../data/data_sources/remote/course_data_source.dart';
import '../../data/repositories/course_repository_imp.dart';
import '../../domain/use_cases/course_use_case.dart';
import '../../domain/entities/course_conduct_data_entity.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/config/local_storage_services.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../shared/domain/entities/response_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
}

mixin CourseVideoScreenService<T extends StatefulWidget> on State<T>
implements _ViewModel {
  late _ViewModel _view;
  late CourseVideoScreenArgs screenArgs;

  final CourseUseCase _courseUseCase = CourseUseCase(
    courseRepository: CourseRepositoryImp(
        courseRemoteDataSource: CourseRemoteDataSourceImp()),
  );

  Future<ResponseEntity> getCourseTopicDetails(
      String userId, String courseId, String topicId) async {
    return _courseUseCase.courseTopicDetailsUseCase(userId, courseId, topicId);
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  ///Stream controllers

  final AppStreamController<CourseConductDataEntity>
  courseConductStreamController = AppStreamController();

  void loadCourseTopicDetails(String courseId, String topicId) async {
    print(courseId);
    LocalStorageService localStorageService =
    await LocalStorageService.getInstance();
    String? userId = localStorageService.getStringValue(StringData.userId);
    courseConductStreamController.add(LoadingState());
    getCourseTopicDetails(userId!, courseId, topicId).then((value) {
      if (value.data != null) {
        courseConductStreamController
            .add(DataLoadedState<CourseConductDataEntity>(value.data));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }
}
