import 'package:adb_mobile/src/core/routes/app_route.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/auth_data_entity.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../data/data_sources/remote/auth_data_source.dart';
import '../../data/repositories/auth_repository_imp.dart';
import '../../domain/use_cases/auth_use_case.dart';
import '../../../../core/service/auth_cache_manager.dart';

abstract class _ViewModel {
  void showWarning(String message);
  void showSuccess(String message);
  void onNavigateToBaseScreen();
}

mixin LoginScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  final AuthUseCase _authUseCase = AuthUseCase(
      authRepository:
          AuthRepositoryImp(authRemoteDataSource: AuthRemoteDataSourceImp()));

  ///Service configurations
  @override
  void initState() {
    super.initState();
    _view = this;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  Future<AuthDataEntity> userLogin(String userName, String password) async {
    return _authUseCase.userLoginUseCase(userName, password);
  }

  void onTapLogin() async {
    if (username.text.isNotEmpty && password.text.isNotEmpty) {
      CustomToasty.of(context).lockUI();

      try {
        AuthDataEntity authDataEntity =
            await userLogin(username.text, password.text);

        if (authDataEntity.id.isNotEmpty) {
          _view.showSuccess("User Logged In");
          CustomToasty.of(context).releaseUI();
          _view.onNavigateToBaseScreen();
        } else {
          _view.showWarning("Something went wrong");
          CustomToasty.of(context).releaseUI();
        }
      } catch (error) {
        _view.showWarning("An error occurred: $error");
      }
    } else {
      if (username.text.isEmpty) {
        _view.showWarning("Username is required");
      }

      if (password.text.isEmpty) {
        _view.showWarning("Password is required");
      }
    }
  }
}
