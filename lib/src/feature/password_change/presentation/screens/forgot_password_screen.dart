import 'dart:async';

import 'package:adb_mobile/src/core/common_widgets/custom_button.dart';
import 'package:adb_mobile/src/core/common_widgets/custom_toasty.dart';
import 'package:adb_mobile/src/core/common_widgets/text_field_widget.dart';
import 'package:adb_mobile/src/core/constants/app_theme.dart';
import 'package:adb_mobile/src/core/constants/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../service/forget_password_screen_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with AppTheme, ForgotPasswordScreenService {
  late Timer _timer = Timer(Duration.zero, () {}); // Default Timer
  int _start = 60;
  bool _isResendButtonDisabled = false;
  bool _isVerifyButtonEnabled = false;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    errorController!.close();
    super.dispose();
  }

  void startResendTimer() {
    requestOtp(context);
    setState(() {
      _isResendButtonDisabled = true;
      _start = 60;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _isResendButtonDisabled = false;
        });
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void _handlePhoneNumberSubmission() {
    if (phoneController.text.isEmpty) {
      CustomToasty.of(context)
          .showWarning("You have to enter your phone number");
    } else {
      requestOtp(context);
      //changeScreenState(ForgotPasswordState.enterOTP);
    }
  }

  void _handleVerification() {
    if (_isVerifyButtonEnabled) {
      validate(context);
      // Add verification logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clr.scaffoldBackgroundColor2,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: size.h32, horizontal: size.w16),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    switch (screenState) {
      case ForgotPasswordState.enterPhone:
        return _buildEnterPhoneView();
      case ForgotPasswordState.enterOTP:
        return _buildEnterOtpView();
      case ForgotPasswordState.enterNewPassword:
        return _buildEnterNewPasswordView();
      default:
        return Container();
    }
  }

  Widget _buildEnterPhoneView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.h32,
        ),
        _buildHeader("পাসওয়ার্ড ভুলে গেছেন?"),
        _buildLottieAnimation(),
        _buildDescription(
            "আপনার পাসওয়ার্ড ভুলে গেছেন? আপনার অফিসিয়াল নম্বরে OTP পেতে অনুগ্রহ করে আপনার ফোন নম্বর লিখুন।"),
        AppTextFieldWithTitle(
          hintText: "Phone Number",
          controller: phoneController,
          keyboardType: TextInputType.number,
          title: "ফোন (Phone)",
        ),
        SizedBox(height: size.h20),
        CustomButton(
          onTap: _handlePhoneNumberSubmission,
          title: "OTP পাঠান",
          bgColor: clr.appPrimaryColorBlue,
        ),
        SizedBox(height: size.h20),
        _buildFooter(),
      ],
    );
  }

  Widget _buildEnterOtpView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.h32,
        ),
        _buildHeader("পাসওয়ার্ড ভুলে গেছেন?"),
        _buildDescription(
            "আপনার ফোনে ${phoneController.text} একটি OTP (One Time Passcode) পাঠানো হয়েছে। আপনার ফোন নম্বর যাচাই করতে অনুগ্রহ করে নিচে OTP লিখুন।"),
        _buildOtpField(),
        _buildResendButton(),
        SizedBox(height: size.h20),
        _buildVerifyButton(),
        SizedBox(height: size.h20),
        _buildFooter(),
      ],
    );
  }

  Widget _buildEnterNewPasswordView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.h32,
        ),
        _buildHeader("আপনার পাসওয়ার্ড পরিবর্তন করুন"),
        _buildLottieAnimation(),
        _buildPasswordFields(),
        SizedBox(height: size.h20),
        CustomButton(onTap: () {
          if(newPassword.text!=confirmPassword.text){
            CustomToasty.of(context).showWarning("New password & confirm password should be same");
          }else{
            newPassword.text.length<6?CustomToasty.of(context).showWarning("Password must be 6 characters"):resetPassword(context);
          }
        }, title: "সাবমিট"),
        SizedBox(height: size.h20),
        _buildFooter(),
      ],
    );
  }

  Widget _buildHeader(String title) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: size.textLarge,
              color: clr.appPrimaryColorBlue,
            ),
          ),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.clear),
        ),
      ],
    );
  }

  Widget _buildLottieAnimation() {
    return Center(
      child: Lottie.asset(ImageAssets.passwordAnimation, height: .3.sh),
    );
  }

  Widget _buildDescription(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: size.textXSmall,
        color: clr.cardColor2,
      ),
    );
  }

  Widget _buildOtpField() {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
        child: PinCodeTextField(
          appContext: context,
          length: 6,
          obscureText: true,
          obscuringCharacter: '*',
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            activeFillColor: Colors.white,
            inactiveColor: clr.greyColor,
            inactiveFillColor: clr.whiteColor,
            selectedFillColor: clr.whiteColor,
            selectedColor: clr.greyColor,
          ),
          cursorColor: Colors.black,
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          errorAnimationController: errorController,
          controller: otpController,
          keyboardType: TextInputType.number,
          boxShadows: const [
            BoxShadow(
              offset: Offset(0, 1),
              color: Colors.black12,
              blurRadius: 10,
            )
          ],
          onCompleted: (v) => setState(() {
            _isVerifyButtonEnabled = v.length == 6;
          }),
          onChanged: (value) => setState(() {
            currentText = value;
            _isVerifyButtonEnabled = value.length == 6;
          }),
          beforeTextPaste: (text) => true,
          pastedTextStyle: TextStyle(
              fontSize: size.textSmall, color: clr.appPrimaryColorBlue),
        ),
      ),
    );
  }

  Widget _buildResendButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Didn't receive the code? ",
          style: TextStyle(color: Colors.black54, fontSize: 15),
        ),
        TextButton(
          onPressed: _isResendButtonDisabled ? null : startResendTimer,
          child: Text(
            _isResendButtonDisabled ? "RESEND ($_start)" : "RESEND",
            style: TextStyle(
              color: _isResendButtonDisabled
                  ? Colors.grey
                  : clr.appPrimaryColorBlue,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVerifyButton() {
    return CustomButton(
      onTap: _handleVerification,
      title: "Verify",
      bgColor: _isVerifyButtonEnabled ? clr.appPrimaryColorBlue : Colors.grey,
    );
  }

  Widget _buildPasswordFields() {
    return Column(
      children: [
        AppTextFieldWithTitle(
          hintText: "নতুন পাসওয়ার্ড",
          title: "নতুন পাসওয়ার্ড",
          controller: newPassword,
          obscureText: true,
        ),
        SizedBox(height: size.h12),
        AppTextFieldWithTitle(
          hintText: "পাসওয়ার্ড নিশ্চিত করুন",
          title: "পাসওয়ার্ড নিশ্চিত করুন",
          controller: confirmPassword,
          obscureText: true,
        ),
        SizedBox(height: size.h20),
      ],
    );
  }

  Widget _buildFooter() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Center(
        child: Text(
          "সাইনইন-এ ফিরে যান",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: size.textMedium,
            color: clr.appPrimaryColorBlue,
          ),
        ),
      ),
    );
  }

  @override
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }

  @override
  void changeScreenState(ForgotPasswordState state) {
    setState(() {
      screenState = state;
    });
  }
}
