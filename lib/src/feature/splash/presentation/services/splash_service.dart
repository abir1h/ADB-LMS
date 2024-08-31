import 'package:flutter/material.dart';

import '../../../../core/config/local_storage_services.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/service/auth_cache_manager.dart';
import '../../../dashboard/data/data_sources/remote/trainee_count_data_source.dart';
import '../../../dashboard/data/repositories/trainee_count_repository_imp.dart';
import '../../../dashboard/domain/use_cases/trainee_count_use_case.dart';
import '../../../shared/domain/entities/response_entity.dart';

abstract class _ViewModel {
  void navigateToBaseScreen();
  void navigateToLandingScreen();
}

mixin SplashService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final TraineeCountUseCase _traineeCountUseCase = TraineeCountUseCase(
    traineeCountRepository: TraineeCountRepositoryImp(
        traineeCountRemoteDataSource: TraineeCountRemoteDataSourceImp()),
  );

  Future<ResponseEntity> getTraineeCountInformation(String userId) async {
    return _traineeCountUseCase.traineeCountInformationUseCase(userId);
  }

  ///Service configurations
  @override
  void initState() {
    super.initState();
    _view = this;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchUserSession();
    });
  }

  //======================Private methods======================
  ///Fetch users from local database
  void _fetchUserSession() async {
    ///Delayed for 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    ///Navigate to logical page
    await AuthCacheManager.isUserLoggedIn()
        ? _loadTraineeCountData()
        : _view.navigateToLandingScreen();
  }

  ///Load Trainee Count
  void _loadTraineeCountData() async {
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    String? userId = localStorageService.getStringValue(StringData.userId);
    if (userId != null) {
      getTraineeCountInformation(userId).then((value) {
        if (value.error != null) {
          //Navigate to landing
          _view.navigateToLandingScreen();
        } else {
          _view.navigateToBaseScreen();
        }
      });
    } else {
      //Navigate to landing
      _view.navigateToLandingScreen();
    }
  }
}
