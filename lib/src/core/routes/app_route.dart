import 'package:adb_mobile/src/feature/course/presentation/screens/course_video_screen.dart';
import 'package:flutter/material.dart';

import '../../feature/authentication/presentation/screens/login_screen.dart';
import '../../feature/authentication/presentation/screens/registration_screen.dart';
import '../../feature/base/presentation/screens/base_screen.dart';
import '../../feature/certificate/presentation/screens/certificate_screen.dart';
import '../../feature/certificate/presentation/screens/certificate_view_screen.dart';
import '../../feature/course/presentation/screens/course_conduct_screen.dart';
import '../../feature/course/presentation/screens/course_list_screen.dart';
import '../../feature/course/presentation/screens/course_overview_screen.dart';
import '../../feature/dashboard/presentation/screens/dashboard_screen.dart';
import '../../feature/landing/presentation/screens/landing_screen.dart';
import '../../feature/notification/presentation/screens/notification_screen.dart';
import '../../feature/password_change/presentation/screens/change_password_screen.dart';
import '../../feature/profile/presentation/screens/profile_screen.dart';
import '../../feature/project_details/presentation/screens/project_details_screen.dart';
import '../../feature/splash/presentation/screens/splash_screen.dart';
import '../../feature/user_mannual/presentation/screens/user_mannual_screen.dart';
import '../../feature/assessment/presentation/screens/exam_info_screen.dart';
import '../../feature/assessment/presentation/screens/exam_screen.dart';

class AppRoute {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static const String splashScreen = "splashScreen";
  static const String loginScreen = "loginScreen";
  static const String landingScreen = "landingScreen";
  static const String regScreen = "regScreen";
  static const String baseScreen = "baseScreen";
  static const String dashboardScreen = "dashboardScreen";
  static const String profileScreen = "profileScreen";
  static const String courseOverViewScreen = "courseOverViewScreen";
  static const String courseConductScreen = "courseConductScreen";
  static const String courseListScreen = "courseListScreen";
  static const String changePassword = "changePassword";
  static const String projectDetails = "projectDetails";
  static const String certificateList = "certificateList";
  static const String userMannual = "userMannual";
  static const String notificationScreen = "notificationScreen";
  static const String certificateViewScreen = "certificateViewScreen";
  static const String examInfoViewScreen = "examInfoViewScreen";
  static const String examViewScreen = "examViewScreen";
  static const String courseVideoScreen = "courseVideoScreen";
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
            return BaseScreen(arguments: setting.arguments);
          case AppRoute.dashboardScreen:
            return const DashboardScreen();
          case AppRoute.profileScreen:
            return const ProfileScreen();
          case AppRoute.courseListScreen:
            return const CourseListScreen();
          case AppRoute.courseOverViewScreen:
            return CourseOverViewScreen(arguments: setting.arguments);
          case AppRoute.courseConductScreen:
            return CourseConductScreen(arguments: setting.arguments);
          case AppRoute.changePassword:
            return const ChangePasswordScreen();
          case AppRoute.projectDetails:
            return ProjectDetails();
          case AppRoute.certificateList:
            return const CertificateListScreen();
          case AppRoute.userMannual:
            return UserMannualScreen();
          case AppRoute.notificationScreen:
            return const NotificationScreen();
          case AppRoute.certificateViewScreen:
            return CertificateViewScreen(arguments: setting.arguments);
          case AppRoute.examInfoViewScreen:
            return ExamInfoScreen(arguments: setting.arguments);
          case AppRoute.examViewScreen:
            return ExamScreen(arguments: setting.arguments);
            return CertificateViewScreen(arguments: setting.arguments);
          case AppRoute.courseVideoScreen:
            return CourseVideoScreen(arguments: setting.arguments);
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
