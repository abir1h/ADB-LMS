import 'package:adb_mobile/src/feature/authentication/presentation/screens/login_screen.dart';
import 'package:adb_mobile/src/feature/authentication/presentation/screens/registration_screen.dart';
import 'package:adb_mobile/src/feature/base/presentation/screens/base_screen.dart';
import 'package:flutter/material.dart';

import '../../feature/landing/presentation/screens/landing_screen.dart';
import '../../feature/splash/presentation/screens/splash_screen.dart';

class AppRoute {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static const String splashScreen = "splashScreen";
  static const String loginScreen = "loginScreen";
  static const String landingScreen = "landingScreen";
  static const String regScreen = "regScreen";
  static const String baseScreen = "baseScreen";
}

mixin RouteGenerator {
  static Route<dynamic> generate(RouteSettings setting) {
    return FadeInOutRouteBuilder(
      builder: (context) {
        switch (setting.name) {
          ///StartUp
          case AppRoute.splashScreen:
            return const SplashScreen();
          case AppRoute.landingScreen:
            return const LandingScreen();
          case AppRoute.loginScreen:
            return const LoginScreen();

          case AppRoute.regScreen:
            return const RegistrationScreen();
          case AppRoute.baseScreen:
            return const BaseScreen();

          default:
            return const SplashScreen();
        }
      },
    );
  }
}

///This defines the animation of routing one page to another
class FadeInOutRouteBuilder extends PageRouteBuilder {
  final WidgetBuilder builder;
  FadeInOutRouteBuilder({required this.builder})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return builder(context);
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return FadeTransition(
            opacity: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: const Interval(
                  0.50,
                  1.00,
                  curve: Curves.linear,
                ),
              ),
            ),
            child: child,
          );
        });
}
