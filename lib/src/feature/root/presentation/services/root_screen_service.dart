import 'package:flutter/material.dart';


abstract class _ViewModel {
  void navigateToLoginScreen();
  void navigateToSignUpScreen();
}

mixin RootScreenService implements _ViewModel {
  late _ViewModel _view;

  ///Service configurations
  @override
  void initState() {
    _view = this;

  }


}
