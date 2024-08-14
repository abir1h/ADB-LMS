import 'package:adb_mobile/src/core/common_widgets/app_dropdown_widget.dart';
import 'package:adb_mobile/src/core/constants/app_theme.dart';
import 'package:adb_mobile/src/feature/password_change/presentation/service/change_password_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen>
    with AppTheme, ChangePasswordService {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),

          child: Icon(
            Icons.arrow_back,
            color: clr.appPrimaryColorBlue,
          ),
        ),
        title: Text(
          'Change Password',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: clr.appPrimaryColorBlue,
              fontSize: size.textSmall),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size.h20, vertical: size.h20),
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "পুরাতন পাসওয়ার্ড",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: size.textSmall,
                  color: clr.blackColor),
            ),
            SizedBox(
              height: size.h12,
            ),
            TextField(
              controller: oldPassword,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 1,
              style: TextStyle(
                  color: clr.textColorBlack,
                  fontSize: size.textSmall,
                  fontWeight: FontWeight.w400,
                  fontFamily: StringData.fontFamilyOpenSans),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: "পুরাতন পাসওয়ার্ড...",
                hintStyle: TextStyle(
                    color: clr.placeHolderTextColorGray,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w400,
                    fontFamily: StringData.fontFamilyPoppins),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: clr.greyColor, width: size.w1),
                  borderRadius: BorderRadius.all(Radius.circular(size.w8)),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: clr.boxStrokeColor, width: size.w1),
                    borderRadius: BorderRadius.all(Radius.circular(size.w8))),
              ),
            ),
            SizedBox(
              height: size.h20,
            ),
            Text(
              "নতুন পাসওয়ার্ড",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: size.textSmall,
                  color: clr.blackColor),
            ),
            SizedBox(
              height: size.h12,
            ),
            TextField(
              controller: newPassword,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 1,
              style: TextStyle(
                  color: clr.textColorBlack,
                  fontSize: size.textSmall,
                  fontWeight: FontWeight.w400,
                  fontFamily: StringData.fontFamilyOpenSans),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: "নতুন পাসওয়ার্ড...",
                hintStyle: TextStyle(
                    color: clr.placeHolderTextColorGray,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w400,
                    fontFamily: StringData.fontFamilyPoppins),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: clr.greyColor, width: size.w1),
                  borderRadius: BorderRadius.all(Radius.circular(size.w8)),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: clr.boxStrokeColor, width: size.w1),
                    borderRadius: BorderRadius.all(Radius.circular(size.w8))),
              ),
            ),
            SizedBox(
              height: size.h20,
            ),
            Text(
              "পাসওয়ার্ড নিশ্চিত করুন",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: size.textSmall,
                  color: clr.blackColor),
            ),
            SizedBox(
              height: size.h12,
            ),
            TextField(
              controller: newPassword,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 1,
              style: TextStyle(
                  color: clr.textColorBlack,
                  fontSize: size.textSmall,
                  fontWeight: FontWeight.w400,
                  fontFamily: StringData.fontFamilyOpenSans),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: "পাসওয়ার্ড নিশ্চিত করুন...",
                hintStyle: TextStyle(
                    color: clr.placeHolderTextColorGray,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w400,
                    fontFamily: StringData.fontFamilyPoppins),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: clr.greyColor, width: size.w1),
                  borderRadius: BorderRadius.all(Radius.circular(size.w8)),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: clr.boxStrokeColor, width: size.w1),
                    borderRadius: BorderRadius.all(Radius.circular(size.w8))),
              ),
            ),
            SizedBox(
              height: size.h24,
            ),
            Container(
              width: 1.sw,
              padding: EdgeInsets.symmetric(vertical: size.h6),
              decoration: BoxDecoration(
                color: clr.appPrimaryColorBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Submit',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: size.textSmall,
                      color: clr.whiteColor),
                ),
              ),
            )
          ],
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
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }
}
