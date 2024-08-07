import 'package:adb_mobile/src/core/common_widgets/custom_button.dart';
import 'package:adb_mobile/src/core/constants/common_imports.dart';
import 'package:flutter/material.dart';

import '../../../../core/common_widgets/text_field_widget.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/image_assets.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/constants/language.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with AppTheme, Language {
  @override
  void initState() {
    super.initState();
    // _callMethod();
  }

  _callMethod() async {
    // ResponseEntity responseEntity = await getAuthors();
    // print(responseEntity.message);
  }

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

            ),
           /* CustomButton(
              onTap: () {},
              title: StringData.regText2,
              bgColor: clr.appSecondaryColorPink,
              boxShadow: [
                BoxShadow(
                  color: clr.blackColor.withOpacity(.3),
                  blurRadius: size.r4,
                  offset: Offset(0.0, size.r1 * 5),
                ),
              ],
            )*/
          ],
        ),
      ),
    );
  }
}
