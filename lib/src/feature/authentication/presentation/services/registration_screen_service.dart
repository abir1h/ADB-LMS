import 'package:flutter/material.dart';

import '../../../../core/service/auth_cache_manager.dart';

abstract class _ViewModel {
  void onSubmit();
  void onClose();
}

mixin RegistrationScreenService implements _ViewModel {
  late _ViewModel _view;

  ///Service configurations
  @override
  void initState() {
    _view = this;
  }
}
