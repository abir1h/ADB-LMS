import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

abstract class _ViewModel {
  void navigateToHomeScreen();
  void navigateToProfileScreen();
  void navigateToCategoryScreen();
  void navigateBookMarkScreen();
}

mixin BaseScreenService<T extends StatefulWidget> on State<T>
    implements _ViewModel {
  late _ViewModel _view;

  ///Service configurations
  @override
  void initState() {
    _view = this;
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  ///Public Fields
  final PageController pageController = PageController();

  ///On Tab selection changed
  void onTabSelected(int newIndex, int oldIndex) {
    ///Jump to +- one page of selected
    if ((math.max<int>(newIndex, oldIndex) - math.min<int>(newIndex, oldIndex) >
        1)) {
      if (newIndex > oldIndex) {
        pageController.jumpToPage(newIndex - 1);
      } else if (newIndex < oldIndex) {
        pageController.jumpToPage(newIndex + 1);
      }
    }

    ///Animate to page
    pageController.animateToPage(
      newIndex,
      duration: const Duration(milliseconds: 170),
      curve: Curves.easeOutCubic,
    );
  }
}
