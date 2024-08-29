import 'dart:convert';

import 'package:adb_mobile/src/core/common_widgets/custom_toasty.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/config/local_storage_services.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/network/api_service.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/password_change_data_source.dart';
import '../../data/repositories/password_change_repository_imp.dart';
import '../../domain/use_cases/password_change_use_case.dart';

abstract class _ViewModel {
  void navigateToLoginScreen();
  void showWarning(String message);
  void showSuccess(String message);
}

mixin ChangePasswordService implements _ViewModel {
  late _ViewModel _view;
  final PasswordChangeUseCase _passwordChangeUseCase = PasswordChangeUseCase(
    passwordRepository: PasswordChangeRepositoryImp(
        passwordChangeDataSource: PasswordChangeDataSourceImp()),
  );

  Future<ResponseEntity> changePassword(String userId, String oldPassword,
      String newPassword, String confirmPassword) async {
    return _passwordChangeUseCase.changePasswordUseCase(
        userId, oldPassword, newPassword, confirmPassword);
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
  }

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  ///Change Password
  changePasswordRequest(BuildContext context, String oldPassword,
      String newPassword, String confirmPassword) async {
    if (_areFieldsEmpty() || !_doPasswordsMatch()) {
      return;
    }
    CustomToasty.of(context).lockUI();
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    String? userId_ = localStorageService.getStringValue(StringData.userId);

    changePassword(
            userId_.toString(), oldPassword, newPassword, confirmPassword)
        .then((value) {
      if (value.status == 1) {

        CustomToasty.of(context).releaseUI();

        _view.showSuccess("Password changed successfully");
        _view.navigateToLoginScreen();
      } else {
        CustomToasty.of(context).releaseUI();

        _view.showWarning(value.message!);
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
