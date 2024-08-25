import 'package:flutter/material.dart';

import '../../domain/entities/mcq_data_entity.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/config/local_storage_services.dart';
import '../../../../core/constants/common_imports.dart';
import '../../data/data_sources/remote/assessment_data_source.dart';
import '../../data/repositories/assessment_repository_imp.dart';
import '../../domain/use_cases/assessment_use_case.dart';

abstract class _ViewModel {
  void showWarning(String message);
}

mixin ExamScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;
  late ExamScreenArgs screenArgs;

  final AssessmentUseCase _assessmentUseCase = AssessmentUseCase(
    assessmentRepository: AssessmentRepositoryImp(
        assessmentDataSource: AssessmentDataSourceImp()),
  );

  Future<List<McqDataEntity>> getQuestions(
      String materialId, String userId) async {
    return _assessmentUseCase.getQuestionsUseCase(materialId, userId);
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  ///Stream controllers

  final AppStreamController<List<McqDataEntity>> examQuestionsStreamController =
      AppStreamController();

  void loadQuestions(String materialId) async {
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    String? userId = localStorageService.getStringValue(StringData.userId);
    examQuestionsStreamController.add(LoadingState());
    getQuestions(materialId, userId!).then((value) {
      if (value.isNotEmpty) {
        examQuestionsStreamController
            .add(DataLoadedState<List<McqDataEntity>>(value));
      } else {
        _view.showWarning("Something went wrong!");
      }
    });
  }
}
