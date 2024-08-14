import 'package:flutter/material.dart';
import 'dart:io';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/config/local_storage_services.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/network/api_service.dart';
import '../../../shared/domain/entities/response_entity.dart';

abstract class _ViewModel {
  void navigateToLoginScreen();
  void showWarning(String message);
}

mixin ChangePasswordService implements _ViewModel {
  late _ViewModel _view;
  /*final UserUseCase _profileUseCase = UserUseCase(
    userRepository: ProfileRepositoryImp(
        profileRemoteDataSource: ProfileRemoteDataSourceImp()),
  );

  Future<ResponseEntity> getProfileInformation(String userId) async {
    return _profileUseCase.userProfileInformationUseCase(userId);
  }*/

  ///Service configurations
  @override
  void initState() {
    _view = this;
  }

  TextEditingController oldPassword=TextEditingController();
  TextEditingController newPassword=TextEditingController();
  TextEditingController confirmPassword=TextEditingController();

}
