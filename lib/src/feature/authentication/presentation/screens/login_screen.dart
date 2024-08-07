import 'package:flutter/material.dart';

import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/text_field_widget.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/constants/common_imports.dart';
import '../services/login_screen_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with AppTheme, Language, LoginScreenService {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clr.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding:
        EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.h24,
            ),
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
              hintText: 'ফোন নম্বর',
              prefixIcon: Icon(Icons.person,color: clr.appPrimaryColorBlue,size: size.h24,),
              obscureText: false,

              controller: TextEditingController(),
            ), SizedBox(
              height: size.h24,
            ),
            AppTextField(
              hintText: 'পাসওয়ার্ড',
              prefixIcon: Icon(Icons.lock,color: clr.appPrimaryColorBlue,size: size.h24,),
              obscureText: true,


              controller: TextEditingController(),

            ),SizedBox(
              height: size.h24,
            ),
            CustomButton(
              onTap: () {},
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
}
