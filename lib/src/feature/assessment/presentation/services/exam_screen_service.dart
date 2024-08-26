import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/common_widgets/custom_action_button.dart';
import '../../../../core/utility/app_label.dart';
import '../../domain/entities/mcq_data_entity.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/common_widgets/app_stream.dart';
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

  late Timer examTimer;
  late DateTime _examStartTime;
  bool _isExamRunning = false;

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

    ///Initialized timer
    _examStartTime = DateTime.now();
    examTimer = Timer.periodic(const Duration(seconds: 1), _onTimerTick);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _onTimerTick(examTimer);
    });
    scrollController.addListener(_scrollValue);
  }

  @override
  void dispose() {
    pageStateStreamController.dispose();
    timerStreamController.close();
    examTimer.cancel();
    super.dispose();
  }

  ///Set screen args and load questions
  void initService(ExamScreenArgs args) {
    if (!mounted) return;
    _isExamRunning = true;

    ///Loading state
    pageStateStreamController.add(LoadingState<PageState>());
    screenArgs = args;
    pageStateStreamController
        .add(DataLoadedState<PageState>(ExamRunningState(screenArgs.examData)));
  }

  final DefaultActionButtonController submitButtonController =
      DefaultActionButtonController();

  ///Stream Controllers
  final AppStreamController<PageState> pageStateStreamController =
      AppStreamController();
  final BehaviorSubject<Duration> timerStreamController = BehaviorSubject();

  final StreamController<String> questionNumberTextStream =
      StreamController.broadcast();
  final StreamController<Map<String, dynamic>> buttonTextStream =
      StreamController.broadcast();
  final StreamController<Map<String, dynamic>> pageArrowButtonStream =
      StreamController.broadcast();
  final StreamController<int> pageSelectedIndexStream =
      StreamController.broadcast();

  final ScrollController scrollController = ScrollController();

  final PageController questionPagerController = PageController();

  void _onTimerTick(Timer timer) {
    ///Exam started
    var elapsedTime = DateTime.now().difference(_examStartTime);
    var remaining =
        Duration(minutes: screenArgs.examInfoDataEntity.durationMnt) -
            elapsedTime;
    timerStreamController.sink.add(remaining);

    ///Exam expired check
    if (remaining.inSeconds <= 0) {
      examTimer.cancel();
      // _view.showExamSubmitDialog();

      ////TODO: Later
      // onSubmitExam(screenArgs.examData);

      // pageStateStreamController.add(
      //     DataLoadedState<PageState>(TimeExpiredState(screenArgs.examData)));
      _isExamRunning = false;
    }
  }

  Future<bool> onGoBack() {
    if (_isExamRunning) {
      // _view.showExamCancellationDialog();
    } else {
      // _view.forceClose();
    }
    Navigator.of(context).pop();
    return Future.value(true);
  }

  _scrollValue() {
    if (scrollController.position.pixels == 0.0) {
      pageArrowButtonStream.add({
        "next": true,
        "previous": false,
      });
    } else if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      pageArrowButtonStream.add({
        "next": false,
        "previous": true,
      });
    } else {
      pageArrowButtonStream.add({
        "next": true,
        "previous": true,
      });
    }
  }

  onQuestionChanged(int index) {
    scrollController.animateTo(index * 32,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    pageSelectedIndexStream.sink.add(index);
    questionNumberTextStream.add(
        "প্রশ্ন: ${replaceEnglishNumberWithBengali("${index + 1}")} / ${replaceEnglishNumberWithBengali(screenArgs.examData.length.toString())}");
    if (index == screenArgs.examData.length - 1) {
      buttonTextStream.add({
        "next": "সাবমিট",
        "previous": index == 0 ? false : true,
      });
    } else {
      buttonTextStream.add({
        "next": "পরবর্তী",
        "previous": index == 0 ? false : true,
      });
    }
  }

  onNextTap() {
    if (questionPagerController.page?.floor() !=
        screenArgs.examData.length - 1) {
      questionPagerController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      // showConfirmationDialog();
    }
  }

  onPreviousButtonTap() {
    questionPagerController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }
}

abstract class PageState {}

class ExamRunningState extends PageState {
  final List<McqDataEntity> examData;
  ExamRunningState(this.examData);
}

class TimeExpiredState extends PageState {
  final List<McqDataEntity> examData;
  // final ExamDataEntity questions;
  // final bool shouldShowAnswerSheet;
  // final DateTime startTime;
  // final DateTime endTime;
  TimeExpiredState(
    this.examData,
    // this.questions,
    // this.shouldShowAnswerSheet,
    // this.startTime,
    // this.endTime,
  );
}
////TODO: Later
// class AnswerSubmittedState extends PageState {
//   final ResultDataEntity resultData;
//   AnswerSubmittedState(this.resultData);
// }
