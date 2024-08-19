import 'package:adb_mobile/src/core/routes/app_route_args.dart';
import 'package:adb_mobile/src/feature/dashboard/domain/entities/course_info_data_entity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/common_widgets/drawer_widget.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../dashboard/presentation/screens/dashboard_screen.dart';
import '../../../dashboard/presentation/widgets/course_loader.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/course_card.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/dashboard_card_widget.dart';
import '../../../../core/routes/app_route.dart';
import '../service/course_list_screen_service.dart';

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen>
    with AppTheme, Language, CourseListScreenService {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clr.scaffoldBackgroundColor,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(
            Icons.menu,
            color: clr.appPrimaryColorBlue,
          ),
        ),
        automaticallyImplyLeading: false,
        leadingWidth: size.w40,
        title: Text(
          " আমার প্রশিক্ষণ ",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: size.textSmall,
              color: clr.appPrimaryColorBlue),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(onPressed: ()=>Navigator.pushNamed(context,AppRoute.notificationScreen), icon: Icon(
                Icons.notifications_sharp,
                color: clr.appPrimaryColorBlue,
              ),)
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
        physics: const BouncingScrollPhysics(),
        child: AppStreamBuilder<List<CourseInfoDataEntity>>(
          stream: courseStreamController.stream,
          loadingBuilder: (context) {
            return CourseLoader();
          },
          dataBuilder: (context, data) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CourseSectionWidget(
                    items: data,
                    buildItem: (BuildContext context, int index, item) {
                      return CourseCard(
                        data: item,
                        onTap: () => Navigator.of(context).pushNamed(
                            AppRoute.courseOverViewScreen,
                            arguments: CourseDetailsScreenArgs(data: item)),
                      );
                    }),
                SizedBox(
                  height: size.h64 + size.h32,
                ),
              ],
            );
          },
          emptyBuilder: (context, message, icon) => Padding(
              padding: EdgeInsets.all(size.h24),
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Lottie.asset(ImageAssets.animEmpty, height: size.h64 * 3),
                  SizedBox(height: size.h8),
                  Text(
                    message,
                    style: TextStyle(
                      color: clr.blackColor,
                      fontSize: size.textSmall,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ]),
              )),
        ),
      ),
    );
  }

  @override
  void navigateToLoginScreen() {
    Navigator.of(context).pushNamed(
      AppRoute.loginScreen,
    );
  }

  @override
  void navigateToSignUpScreen() {
    Navigator.of(context).pushNamed(
      AppRoute.regScreen,
    );
  }

  @override
  showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }
}
