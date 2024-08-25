import 'package:flutter/material.dart';

import '../../../../core/routes/app_route_args.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/config/local_storage_services.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/assessment_data_source.dart';
import '../../data/repositories/assessment_repository_imp.dart';
import '../../domain/entities/exam_info_data_entity.dart';
import '../../domain/use_cases/assessment_use_case.dart';

abstract class _ViewModel {
  void showWarning(String message);
}

mixin ExamInfoScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;
  late ExamInfoScreenArgs screenArgs;

  final AssessmentUseCase _assessmentUseCase = AssessmentUseCase(
    assessmentRepository: AssessmentRepositoryImp(
        assessmentDataSource: AssessmentDataSourceImp()),
  );

  Future<ResponseEntity> getExamInfo(String materialId, String userId) async {
    return _assessmentUseCase.examInfoUseCase(materialId, userId);
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  ///Stream controllers

  final AppStreamController<ExamInfoDataEntity> examInfoStreamController =
      AppStreamController();

  void loadExamInfoDetails(String materialId) async {
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    String? userId = localStorageService.getStringValue(StringData.userId);
    examInfoStreamController.add(LoadingState());
    getExamInfo(materialId, userId!).then((value) {
      if (value.data != null) {
        examInfoStreamController
            .add(DataLoadedState<ExamInfoDataEntity>(value.data));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }
}
