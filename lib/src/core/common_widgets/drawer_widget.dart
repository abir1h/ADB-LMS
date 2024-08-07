import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/local_storage_services.dart';
import '../routes/app_route.dart';
import '../service/auth_cache_manager.dart';
import '../service/notifier/app_events_notifier.dart';
import 'custom_dialog_widget.dart';
import 'custom_switch_button.dart';
import '../utility/app_label.dart';
import '../constants/common_imports.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget>
    with AppTheme, Language, AppEventsNotifier {
  // final AccessibilityController accessibilityController =
  //     Get.put(AccessibilityController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: clr.shadeWhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(size.w8)),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: size.h64)
            ],
          ),
        ),
      ),
    );
  }


  // void showLogoutPromptDialog() {
  //   CustomDialogWidget.show(
  //     context: context,
  //     title: label(e: en.logoutWarningText, b: bn.logoutWarningText),
  //     infoText: label(
  //         e: "Your ID login is required for your courses and assessment news.",
  //         b: "আপনার কোর্সগুলো এবং মূল্যায়নের খবরের জন্য আপনার আইডি লগইন থাকা প্রয়োজন।"),
  //     leftButtonText: label(e: en.cancelText, b: bn.cancelText),
  //     rightButtonText: label(e: en.exitText, b: bn.exitText),
  //   ).then((value) {
  //     if (value) {
  //       AuthCacheManager.userLogout();
  //       Navigator.of(context).pushNamedAndRemoveUntil(
  //           AppRoute.authenticationScreen, (x) => false);
  //     }
  //   });
  // }

  @override
  void onEventReceived(EventAction action) {
    if (action == EventAction.drawer) {
      if (mounted) {
        setState(() {});
      }
    }
  }
}

class DrawerLinkWidget extends StatelessWidget with AppTheme {
  final Color cardColor;
  final IconData? icon;
  final Color? iconColor;
  final String? svgIcon;
  final String text;
  final Widget? widget;
  final VoidCallback onTap;
  const DrawerLinkWidget({
    Key? key,
    this.cardColor = Colors.transparent,
    this.icon,
    this.iconColor,
    this.svgIcon,
    required this.text,
    this.widget,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
        decoration: BoxDecoration(
          color: cardColor,
          border: Border(
              bottom: BorderSide(width: size.h1, color: clr.cardStrokeColor)),
        ),
        child: Row(
          children: [
            if (icon != null)
              Padding(
                padding: EdgeInsets.only(right: size.w10),
                child: Icon(
                  icon,
                  size: size.r24,
                  color: iconColor ?? clr.iconColorHint,
                ),
              ),
            if (svgIcon != null)
              Padding(
                padding: EdgeInsets.only(right: size.w10),
                child: SvgPicture.asset(
                  svgIcon!,
                  height: size.h24,
                  colorFilter: ColorFilter.mode(
                      iconColor ?? clr.iconColorHint, BlendMode.srcIn),
                  // color: clr.hintIconColor,
                ),
              ),
            Expanded(
              child: Text(text,
                  style: TextStyle(
                    color: clr.textColorAppleBlack,
                    fontSize: size.textSmall,
                    fontFamily: StringData.fontFamilyPoppins,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            if (widget != null) widget!
          ],
        ),
      ),
    );
  }
}
