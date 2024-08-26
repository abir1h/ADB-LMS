import 'package:flutter/material.dart';

import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/config/local_storage_services.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../assessment/data/data_sources/remote/assessment_data_source.dart';
import '../../../assessment/data/repositories/assessment_repository_imp.dart';
import '../../../assessment/domain/use_cases/assessment_use_case.dart';
import '../../domain/entities/mcq_data_entity.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void onTapExamDetailsScreen(List<McqDataEntity> data);
}

mixin ExamInfoDetailsScreenService<T extends StatefulWidget> on State<T>
implements _ViewModel {
  late _ViewModel _view;


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

  void onTapStartExam(String materialId) async{
    if (!mounted) return;
    CustomToasty.of(context).lockUI();
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    String? userId = localStorageService.getStringValue(StringData.userId);
    getQuestions(materialId, userId!).then((value) {
      CustomToasty.of(context).releaseUI();
      if (value.isNotEmpty) {
        _view.onTapExamDetailsScreen(value);
      } else {
        _view.showWarning("Something went wrong!");
      }
    });
  }
}
