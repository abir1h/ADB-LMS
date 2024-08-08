import 'dart:io';

import 'package:adb_mobile/src/feature/authentication/domain/entities/auth_data_entity.dart';
import 'package:flutter/material.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/config/local_storage_services.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/network/api_service.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/user_data_source.dart';
import '../../data/repositories/profile_repository_imp.dart';
import '../../domain/entities/user_data_entity.dart';
import '../../domain/use_cases/profile_use_case.dart';

abstract class _ViewModel {
  void navigateToLoginScreen();
  void navigateToSignUpScreen();
  void showWarning(String message);
}

mixin ProfileScreenService implements _ViewModel {
  late _ViewModel _view;
  final UserUseCase _profileUseCase = UserUseCase(
    userRepository: ProfileRepositoryImp(
        profileRemoteDataSource: ProfileRemoteDataSourceImp()),
  );

  Future<ResponseEntity> getProfileInformation(String userId) async {
    return _profileUseCase.userProfileInformationUseCase(userId);
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
    _loadProfileData();
  }

  ///Stream controllers
  final AppStreamController<UserDataEntity> categoryDataStreamController =
      AppStreamController();

  ///Load Category list
  void _loadProfileData() async {
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    String? userId = localStorageService.getStringValue(StringData.userId);
    print(userId);
    categoryDataStreamController.add(LoadingState());
    getProfileInformation(userId!).then((value) {
      print(value);
      if (value.data != null) {
        categoryDataStreamController
            .add(DataLoadedState<UserDataEntity>(value.data));
      } else if (value.data.isEmpty) {
        categoryDataStreamController.add(EmptyState(message: 'No Data Found'));
      } else {
        _view.showWarning(value.message!);
      }
    });
  }

  ///UploadProfile
  uploadProfile(File files,BuildContext context) async {

    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    String? userId = localStorageService.getStringValue(StringData.userId);

     Server.instance.uploadProfilePicture(
        url: "${ApiCredential.uploadPhoto}?userId=$userId",
        file: files).then((v){
       _loadProfileData();

     });
  }
}
