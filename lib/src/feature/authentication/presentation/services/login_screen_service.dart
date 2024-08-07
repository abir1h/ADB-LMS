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
}

mixin LoginScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  final AuthUseCase _authUseCase = AuthUseCase(
      authRepository:
      AuthRepositoryImp(authRemoteDataSource: AuthRemoteDataSourceImp()));

  ///Service configurations
  @override
  void initState() {
    _view = this;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }


  Future<AuthDataEntity> userLogin(
      String userName, String password) async {
    return _authUseCase.userLoginUseCase(userName, password);
  }

  void onTapLogin(String userName, String password) async {
    CustomToasty.of(context).lockUI();
    AuthDataEntity authDataEntity = await userLogin(userName, password);
    if (authDataEntity.id.isNotEmpty) {
      _view.showSuccess("User Logged In");
      // _view.onSuccessRequest();
    } else {
      _view.showWarning("Something went wrong");
    }
    CustomToasty.of(context).releaseUI();
  }
}
