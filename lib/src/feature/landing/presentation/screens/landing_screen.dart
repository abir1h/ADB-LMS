import 'package:adb_mobile/src/core/common_widgets/custom_button.dart';
import 'package:adb_mobile/src/core/constants/common_imports.dart';
import 'package:adb_mobile/src/feature/landing/presentation/services/landing_screen_service.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/image_assets.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/constants/language.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> with AppTheme, Language,LandingScreenService {
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
            Text(
              StringData.landingDescription,
              style: TextStyle(
                  fontSize: size.textSmall,
                  fontWeight: FontWeight.w400,
                  color: clr.textColorBlack),
            ),
            SizedBox(
              height: size.h20,
            ),
            Text(
              StringData.landingDescriptionText,
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: size.textSmall,
                  fontWeight: FontWeight.w400,
                  color: clr.appPrimaryColorBlue),
            ),
            SizedBox(
              height: size.h20,
            ),
            Text(
              StringData.regText,
              style: TextStyle(
                  fontSize: size.textSmall,
                  fontWeight: FontWeight.w400,
                  color: clr.textColorBlack),
            ),
            SizedBox(
              height: size.h20,
            ),
            CustomButton(
              onTap: navigateToLoginScreen,
              title: StringData.loginText2,
              boxShadow: [
                BoxShadow(
                  color: clr.blackColor.withOpacity(.3),
                  blurRadius: size.r4,
                  offset: Offset(0.0, size.r1 * 5),
                ),
              ],
            ) ,SizedBox(
              height: size.h32,
            ),Text(
              StringData.newUserText,
              style: TextStyle(
                  fontSize: size.textSmall,
                  fontWeight: FontWeight.w400,
                  color: clr.textColorBlack),
            ),
            SizedBox(
              height: size.h20,
            ),
            CustomButton(
              onTap: navigateToSignUpScreen,
              title: StringData.regText2,
              bgColor: clr.appSecondaryColorPink,
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
  void navigateToLoginScreen() {
    Navigator.of(context)
        .pushNamed(AppRoute.loginScreen,);
  }

  @override
  void navigateToSignUpScreen() {
    Navigator.of(context)
        .pushNamed(AppRoute.regScreen,);
  }
}
