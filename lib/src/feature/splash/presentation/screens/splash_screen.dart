import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/image_assets.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/routes/app_route.dart';
// import '../../../../core/routes/app_routes.dart';
import '../services/splash_service.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/utility/app_label.dart';
// import '../../../book/presentation/services/book_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with AppTheme, Language, SplashService {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                ImageAssets.icLogo,

                fit: BoxFit.cover,
              ),
            ),

          /*  Text(
              label(e: en.splashScreenText, b: bn.splashScreenText),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: clr.appPrimaryColorBlue,
                  fontSize: size.textXXSmall + size.textXXSmall,
                  fontWeight: FontWeight.w600,
                  fontFamily: StringData.fontFamilyPoppins),
            ),*//*Text(
              label(e: en.splashScreenText, b: bn.splashScreenText),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: clr.appPrimaryColorBlue,
                  fontSize: size.textXXSmall + size.textXXSmall,
                  fontWeight: FontWeight.w600,
                  fontFamily: StringData.fontFamilyPoppins),
            ),*/
          ],
        ),
      ),
    );
  }

  @override
  void navigateToLandingScreen() {
    // Navigator.of(context)
    //     .pushNamedAndRemoveUntil(AppRoute.landingScreen, (x) => false);
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoute.landingScreen, (x) => false);
  }

  @override
  void navigateToAuthScreen() {
   /* Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoute.authenticationScreen, (x) => false);*/
  }
}
