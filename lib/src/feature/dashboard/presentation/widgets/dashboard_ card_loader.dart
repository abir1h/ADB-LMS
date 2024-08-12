import 'package:adb_mobile/src/core/constants/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardCardLoader extends StatelessWidget with AppTheme {
  final bool? primary;
  final Color bgColor, borderColor;
  final Icon? icon;
  final FaIcon? faIcon;
  final String title, subTitle;
  const DashboardCardLoader(
      {super.key,
        this.primary,
        required this.bgColor,
        required this.borderColor,
        this.icon,
        required this.title,
        required this.subTitle,  this.faIcon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 45),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.r10),
            color: bgColor,
          ),
          child: Center(
            child: Column(
              children: [
                Text(
                  title,
                  style:
                  TextStyle(fontWeight: FontWeight.w500, color: clr.whiteColor,fontSize: size.textSmall),
                ),SizedBox(height: size.h16,),CircularProgressIndicator(color: clr.whiteColor,)
              ],
            ),
          ),
        ),
        Positioned(
          top: -size.h24,
          right: primary != null ? size.w56 + size.w56 + size.w32 : size.h64,
          child: Container(
            padding: EdgeInsets.all(size.w2),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: borderColor),
            child: CircleAvatar(
              radius: size.r28,
              backgroundColor: bgColor,
              child: icon ?? faIcon,
            ),
          ),
        ),
      ],
    );
  }
}