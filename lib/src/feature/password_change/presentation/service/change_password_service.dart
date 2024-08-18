import 'dart:convert';

import 'package:adb_mobile/src/core/common_widgets/custom_toasty.dart';
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
  void showSuccess(String message);
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

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  ///Change Password
  changeName(BuildContext context) async {
    if (_areFieldsEmpty() || !_doPasswordsMatch()) {
      return;
    }
    CustomToasty.of(context).lockUI();
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    String? userId = localStorageService.getStringValue(StringData.userId);

    Map<String, dynamic> fields = {
      "OldPassword": oldPassword.text,
      "NewPassword": newPassword.text,
      "ConfirmPassword": confirmPassword.text
    };

    Server.instance
        .postRequest(
            url: "${ApiCredential.changePassword}?userId=$userId",
            postData: fields)
        .then((v) {
      if (v['Status'] == 1) {
        CustomToasty.of(context).releaseUI();

        _view.showSuccess(v['Message']);
      } else {
        CustomToasty.of(context).releaseUI();

        _view.showWarning(v['Message']);
      }
    });
  }

  bool _areFieldsEmpty() {
    if (oldPassword.text.isEmpty ||
        newPassword.text.isEmpty ||
        confirmPassword.text.isEmpty) {
      _view.showWarning("Please enter all fields");
      return true;
    }
    return false;
  }

  bool _doPasswordsMatch() {
    if (newPassword.text.trim() != confirmPassword.text.trim()) {
      _view.showWarning("New Password doesn't match with confirm password");
      return false;
    }
    return true;
  }
}
