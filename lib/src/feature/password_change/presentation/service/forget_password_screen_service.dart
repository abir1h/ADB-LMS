import 'dart:async';

import '../../data/repositories/password_change_repository_imp.dart';
import '../../domain/use_cases/password_change_use_case.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../shared/domain/entities/response_entity.dart';
import '../../data/data_sources/remote/password_change_data_source.dart';

enum ForgotPasswordState { enterPhone, enterOTP, enterNewPassword }

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
  changeScreenState(ForgotPasswordState state);
}

mixin ForgotPasswordScreenService implements _ViewModel {
  late _ViewModel _view;
  final PasswordChangeUseCase _passwordChangeUseCase = PasswordChangeUseCase(
    passwordRepository: PasswordChangeRepositoryImp(
        passwordChangeDataSource: PasswordChangeDataSourceImp()),
  );

  Future<ResponseEntity> requestOTP(String phone) async {
    return _passwordChangeUseCase.requestOtpUseCase(phone);
  }

  Future<ResponseEntity> validateOTP(String phone, String otp) async {
    return _passwordChangeUseCase.validateOtpUseCase(phone, otp);
  }

  ///Service configurations
  @override
  void initState() {
    _view = this;
  }

  ForgotPasswordState screenState = ForgotPasswordState.enterPhone;

  final formKey = GlobalKey<FormState>();
  bool hasError = false;
  String currentText = "";

  StreamController<ErrorAnimationType>? errorController;

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  ///Change Password
  Future requestOtp(BuildContext context) async {
    CustomToasty.of(context).lockUI();
    requestOTP(phoneController.text).then((value) {
      if (value.status == 1) {
        CustomToasty.of(context).releaseUI();

        CustomToasty.of(context).showSuccess("OTP send succesfully");
        _view.changeScreenState(ForgotPasswordState.enterOTP);

        return value;
      } else {
        CustomToasty.of(context).releaseUI();

        CustomToasty.of(context).showWarning(value.message!);
        return value;
      }
    });
  }

  Future validate(BuildContext context) async {
    CustomToasty.of(context).lockUI();
    validateOTP(phoneController.text, otpController.text).then((value) {
      if (value.status == 1) {
        CustomToasty.of(context).releaseUI();
        CustomToasty.of(context).showSuccess("OTP validated succesfully");
        _view.changeScreenState(ForgotPasswordState.enterNewPassword);

        return value;
      } else {
        CustomToasty.of(context).releaseUI();
        CustomToasty.of(context).showWarning(value.message!);
        return value;
      }
    });
  }
}
