import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../constants/common_imports.dart';
import 'custom_button.dart';

mixin CustomDialogWidget {
  static Future<bool> show(
      {required BuildContext context,
      required String infoText,
      String title = "Are You Sure?",
      String rightButtonText = "Yes",
      String leftButtonText = "Cancel",
      String singleButtonText = "Close",
      bool singleButton = false,
      IconData icon = Icons.logout}) {
    Completer<bool> completer = Completer();
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            if (!singleButton) {
              Navigator.of(context).pop();
            }
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: GestureDetector(
              onTap: () {},
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: ThemeSize.instance.w24,
                      vertical: ThemeSize.instance.h24),
                  padding: EdgeInsets.symmetric(
                      horizontal: ThemeSize.instance.w20,
                      vertical: ThemeSize.instance.h20),
                  decoration: BoxDecoration(
                    color: ThemeColor.instance.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: ThemeSize.instance.h10),
                          Icon(icon,
                              size: 32.r,
                              color: ThemeColor.instance.appPrimaryColorGreen),
                          SizedBox(height: ThemeSize.instance.h12),
                          Text(
                            title,
                            style: TextStyle(
                                color: ThemeColor.instance.textColorBlack,
                                fontSize: ThemeSize.instance.textMedium,
                                fontWeight: FontWeight.w600,
                                fontFamily: StringData.fontFamilyPoppins),
                            textAlign: singleButton
                                ? TextAlign.left
                                : TextAlign.center,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 14.h),
                            child: Text(
                              infoText,
                              style: TextStyle(
                                  color: ThemeColor.instance.textColorBlack,
                                  fontSize: ThemeSize.instance.textSmall,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: StringData.fontFamilyPoppins),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          SizedBox(height: ThemeSize.instance.h32),
                          if (singleButton)
                            CustomButton(
                                onTap: () => Navigator.of(context).pop(true),
                                title: singleButtonText),
                          if (!singleButton)
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () =>
                                        Navigator.of(context).pop(false),
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w, vertical: 10.w),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.w),
                                        color: ThemeColor
                                            .instance.appPrimaryColorGreen,
                                        border: Border.all(
                                            color: ThemeColor
                                                .instance.appPrimaryColorGreen,
                                            width: 1.w),
                                      ),
                                      child: Center(
                                        child: Text(
                                          leftButtonText,
                                          style: TextStyle(
                                              color: ThemeColor
                                                  .instance.shadeWhiteColor2,
                                              fontSize:
                                                  ThemeSize.instance.textSmall,
                                              fontWeight: FontWeight.w500,
                                              fontFamily:
                                                  StringData.fontFamilyPoppins),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () =>
                                        Navigator.of(context).pop(true),
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w, vertical: 10.w),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.w),
                                        color: ThemeColor
                                            .instance.shadeWhiteColor2,
                                        border: Border.all(
                                            color: ThemeColor
                                                .instance.appPrimaryColorGreen,
                                            width: 1.w),
                                      ),
                                      child: Center(
                                        child: Text(
                                          rightButtonText,
                                          style: TextStyle(
                                              color: ThemeColor.instance
                                                  .appPrimaryColorGreen,
                                              fontSize:
                                                  ThemeSize.instance.textSmall,
                                              fontWeight: FontWeight.w500,
                                              fontFamily:
                                                  StringData.fontFamilyPoppins),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                      if (!singleButton)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: InkWell(
                            onTap: () => Navigator.of(context).pop(false),
                            child: Icon(
                              Icons.close,
                              color: ThemeColor.instance.iconColorBlack,
                              size: ThemeSize.instance.r20,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ).then((x) {
      if (x != null && x) {
        completer.complete(true);
      } else {
        completer.complete(false);
      }
    });
    return completer.future;
  }
}
