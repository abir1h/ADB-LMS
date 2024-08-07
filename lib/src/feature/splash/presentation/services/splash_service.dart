import 'package:flutter/material.dart';

import '../../../../core/service/auth_cache_manager.dart';

abstract class _ViewModel {
  void navigateToAuthScreen();
  void navigateToLandingScreen();
}

mixin SplashService implements _ViewModel {
  late _ViewModel _view;

  ///Service configurations
  @override
  void initState() {
    _view = this;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchUserSession();
    });
  }

  //======================Private methods======================
  ///Fetch users from local database
  void _fetchUserSession() async {
    ///Delayed for 2 seconds
    await Future.delayed(const Duration(milliseconds: 500));

    ///Navigate to logical page
    // await AuthCacheManager.isUserLoggedIn()
    //     ?
    _view.navigateToLandingScreen()
        // : _view.navigateToAuthScreen()
    // _view.navigateToAuthScreen()
    ;
  }
}
