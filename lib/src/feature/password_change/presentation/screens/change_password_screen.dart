import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/text_field_widget.dart';
import '../service/change_password_service.dart';
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
            AppTextFieldWithTitle(
              title: "পুরাতন পাসওয়ার্ড",
              hintText: "পুরাতন পাসওয়ার্ড...",
              controller: oldPassword,
              obscureText: true,
            ),
            SizedBox(
              height: size.h20,
            ),
            AppTextFieldWithTitle(
              title: "নতুন পাসওয়ার্ড",
              hintText: "নতুন পাসওয়ার্ড...",
              controller: newPassword,
              obscureText: true,
            ),
            SizedBox(
              height: size.h20,
            ),
            AppTextFieldWithTitle(
              title: "পাসওয়ার্ড নিশ্চিত করুন",
              hintText: "পাসওয়ার্ড নিশ্চিত করুন...",
              controller: newPassword,
              obscureText: true,
            ),
            SizedBox(
              height: size.h24,
            ),
            GestureDetector(
              onTap: () {
                if ([oldPassword.text, newPassword.text, confirmPassword.text]
                    .every((text) => text.isNotEmpty)) {
                  if (newPassword.text == confirmPassword.text) {
                    changePasswordRequest(context, oldPassword.text,
                        newPassword.text, confirmPassword.text);
                  } else {
                    CustomToasty.of(context).showWarning(
                        "New password & confirm password must be the same");
                  }
                } else {
                  CustomToasty.of(context)
                      .showWarning("Please enter all required fields");
                }
              },
              child: Container(
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

  @override
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
  }
}
