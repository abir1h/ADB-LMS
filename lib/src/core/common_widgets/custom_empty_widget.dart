import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utility/app_label.dart';
import '../constants/common_imports.dart';

class CustomEmptyWidget extends StatelessWidget with AppTheme, Language {
  final IconData icon;
  final String? title;
  final String message;

  const CustomEmptyWidget(
      {super.key,
      this.icon = Icons.content_paste_off,
      this.title,
      required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clr.scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 100.r, color: clr.iconColorWhiteIce),
                  SizedBox(height: size.h20),
                  Text(
                    title ??
                        label(e: en.noFileFoundText, b: bn.noFileFoundText),
                    style: TextStyle(
                        color: clr.blackColor,
                        fontSize: size.textXMedium,
                        fontWeight: FontWeight.w600,
                        fontFamily: StringData.fontFamilyPoppins),
                  ),
                  SizedBox(height: size.h12),
                  Text(
                    message,
                    style: TextStyle(
                        color: clr.textColorBlack,
                        fontSize: size.textSmall,
                        fontWeight: FontWeight.w500,
                        fontFamily: StringData.fontFamilyPoppins),
                  ),
                  // SizedBox(height: size.h4 + size.h32),
                  // Container(
                  //   padding: EdgeInsets.symmetric(
                  //       horizontal: size.w32, vertical: size.h8),
                  //   decoration: BoxDecoration(
                  //       color: clr.appPrimaryColorGreen,
                  //       borderRadius: BorderRadius.circular(size.w1 + size.w4)),
                  //   child: Text(
                  //     label(e: en.backToHomeText, b: bn.backToHomeText),
                  //     style: TextStyle(
                  //         color: clr.whiteColor,
                  //         fontSize: size.textSmall,
                  //         fontWeight: FontWeight.w500,
                  //         fontFamily: StringData.fontFamilyPoppins),
                  //   ),
                  // )
                ],
              ),
            ),
            // Positioned(
            //   top: size.h16 - size.h1,
            //   right: size.w16,
            //   child: CustomSwitchButton(
            //     value: App.currentAppLanguage == AppLanguage.english,
            //     textOn: 'EN',
            //     textSize: size.textXXSmall,
            //     textOff: 'বাং',
            //     bgColor: clr.whiteColor,
            //     width: 64.w,
            //     animationDuration: const Duration(milliseconds: 300),
            //     onChanged: (bool state) {
            //       // App.setAppLanguage(state ? 1 : 0).then((value) {
            //       //   if (mounted) {
            //       //     setState(() {});
            //       //   }
            //       // });
            //     },
            //     buttonHolder: const Icon(
            //       Icons.check,
            //       color: Colors.transparent,
            //     ),
            //     onTap: () {},
            //     onDoubleTap: () {},
            //     onSwipe: () {},
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
