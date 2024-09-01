import 'package:flutter/material.dart';

import '../../../../core/routes/app_route_args.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/text_field_widget.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route.dart';
import '../services/login_screen_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with AppTheme, Language, LoginScreenService {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clr.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.h24,
            ),
            IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.arrow_back)),
            Center(
              child: Image.asset(
                ImageAssets.icLogo,
                height: size.h56 + size.h56,
              ),
            ),
            SizedBox(
              height: size.h24,
            ),
            Text(
              StringData.splashScreenText,
              style: TextStyle(
                  fontSize: size.textXMedium,
                  fontWeight: FontWeight.w700,
                  color: clr.appPrimaryColorBlue),
            ),
            SizedBox(
              height: size.h24,
            ),
            AppTextField(
              hintText: StringData.userNameHint,
              prefixIcon: Icon(
                Icons.person,
                color: clr.appPrimaryColorBlue,
                size: size.h24,
              ),
              obscureText: false,
              controller: username,
            ),
            SizedBox(
              height: size.h24,
            ),
            AppTextField(
              hintText: 'পাসওয়ার্ড',
              prefixIcon: Icon(
                Icons.lock,
                color: clr.appPrimaryColorBlue,
                size: size.h24,
              ),
              obscureText: true,
              controller: password,
            ),
            SizedBox(
              height: size.h24,
            ),
            CustomButton(
              onTap: onTapLogin,
              title: StringData.enterText,
              bgColor: clr.appPrimaryColorBlue,
              boxShadow: [
                BoxShadow(
                  color: clr.blackColor.withOpacity(.3),
                  blurRadius: size.r4,
                  offset: Offset(0.0, size.r1 * 5),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }

  @override
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
  }

  @override
  void onNavigateToBaseScreen() {
    Navigator.pushNamed(context, AppRoute.baseScreen,arguments: BaseScreenArgs(index: 0));
  }
}
