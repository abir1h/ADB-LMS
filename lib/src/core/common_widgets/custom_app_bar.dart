import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_theme.dart';
import '../constants/strings.dart';

class CustomAppBar extends StatelessWidget with AppTheme {
  const CustomAppBar(
      {super.key,
      required this.title,
      this.primaryColor,
      required this.leadingOnPressed,
      required this.trailingOnPressed,
      this.leading,
      this.trailing,
      required this.hasDivider,
      required this.hasMenu,
      required this.automaticallyImplyLeading,
      required this.toolbarHeight});

  final String title;
  final Color? primaryColor;
  final Function() leadingOnPressed;
  final Function() trailingOnPressed;
  final Widget? leading;
  final Widget? trailing;
  final bool hasDivider;
  final bool hasMenu;
  final bool automaticallyImplyLeading;
  final double toolbarHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          elevation: 0,
          backgroundColor: primaryColor,
          titleSpacing: 0,
          leadingWidth: hasMenu ? 56.w : 16.w,
          automaticallyImplyLeading: automaticallyImplyLeading,
          scrolledUnderElevation: 0,
          leading: hasMenu
              ? GestureDetector(onTap: leadingOnPressed, child: leading)
              : const SizedBox(),
          toolbarHeight: toolbarHeight,
          title: Text(
            title,
            style: TextStyle(
              fontSize: size.textXMedium,
              fontFamily: StringData.fontFamilyPoppins,
              fontWeight: FontWeight.w500,
              color: clr.appPrimaryColorBlue,
            ),
          ),
          centerTitle: false,
          actions: [
            Padding(
              padding: EdgeInsets.only(
                  top: size.h16, right: size.w16, bottom: size.h16),
              child:
                  GestureDetector(onTap: trailingOnPressed, child: trailing!),
            )
          ],
        ),
        hasDivider
            ? Expanded(
                child: Divider(
                  color: clr.cardStrokeColor,
                  thickness: 1,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
