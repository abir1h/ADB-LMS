import 'package:flutter/material.dart';

import '../../../../core/service/auth_cache_manager.dart';

abstract class _ViewModel {
  void navigateToBaseScreen();
  void navigateToLandingScreen();
}

mixin SplashService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

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
        ? _view.navigateToBaseScreen()
        : _view.navigateToLandingScreen();
  }
}
