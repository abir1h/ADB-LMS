import 'package:flutter/material.dart';


import '../../feature/splash/presentation/screens/splash_screen.dart';


class AppRoute {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static const String splashScreen = "splashScreen";
  static const String authenticationScreen = "authenticationScreen";
  static const String eMISWebViewScreen = "eMISWebViewScreen";

  static const String landingScreen = "landingScreen";
  static const String rootScreen = "rootScreen";
  static const String notificationScreen = "notificationScreen";
  static const String leaderboardScreen = "leaderboardScreen";
  static const String overallProgressScreen = "overallProgressScreen";
  static const String courseListScreen = "courseListScreen";
  static const String courseDetailsScreen = "courseDetailsScreen";
  static const String courseLearningOutcomeScreen =
      "courseLearningOutcomeScreen";
  static const String courseScriptScreen = "courseScriptScreen";
  static const String transcriptVideoScreen = "transcriptVideoScreen";
  static const String courseAssignmentScreen = "courseAssignmentScreen";
  static const String courseLiveClassScreen = "courseLiveClassScreen";
  static const String courseAssessmentScreen = "courseAssessmentScreen";
  static const String discussionScreen = "discussionScreen";
  static const String moduleDiscussionsScreen = "moduleDiscussionsScreen";
  static const String assignmentScreen = "assignmentScreen";
  static const String collaborativeAssignmentScreen =
      "collaborativeAssignmentScreen";
  static const String collaborativeAssignmentInstructionScreen =
      "collaborativeAssignmentInstructionScreen";
  static const String assignmentReviewScreen =
      "assignmentReviewScreen";
  static const String assignmentSubmitScreen = "assignmentSubmitScreen";
  static const String assessmentScrollViewScreen = "assessmentScrollViewScreen";
  static const String assessmentSlideViewScreen = "assessmentSlideViewScreen";
  static const String detailedDiscussion = "detailedDiscussion";
  static const String discussionListScreen = "discussionListScreen";
  static const String noteDetailsScreen = "noteDetailsScreen";
  static const String noteEditScreen = "noteEditScreen";
  static const String circularScreen = "circularScreen";
  static const String circularDetailsScreen = "circularDetailsScreen";
  static const String documentViewScreen =
      "documentViewScreen";
}

mixin RouteGenerator {
  static Route<dynamic> generate(RouteSettings setting) {
    return FadeInOutRouteBuilder(
      builder: (context) {
        switch (setting.name) {
          ///StartUp
          case AppRoute.splashScreen:
            return const SplashScreen();

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
