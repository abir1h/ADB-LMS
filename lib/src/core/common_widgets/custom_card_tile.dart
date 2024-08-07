import 'package:flutter/material.dart';

import '../constants/app_theme.dart';

class CustomCardTile extends StatelessWidget with AppTheme {
  final double? height;
  final double? width;
  final double? horizontal;
  final double? vertical;
  final Color? bgColor;
  final double? radius;
  final Color? borderColor;
  final Widget child;
  const CustomCardTile(
      {super.key,
      this.height,
      this.width,
      this.horizontal,
      this.vertical,
      this.bgColor,
      this.radius,
      this.borderColor,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.symmetric(
          horizontal: horizontal ?? size.w16, vertical: vertical ?? size.h12),
      decoration: BoxDecoration(
        color: bgColor ?? clr.shadeWhiteColor,
        borderRadius: BorderRadius.circular(radius ?? size.w8),
        border: Border.all(
            color: borderColor ?? clr.cardStrokeColor, width: size.w1),
        boxShadow: [
          BoxShadow(
            color: clr.blackColor.withOpacity(.2),
            blurRadius: size.r8,
            offset: Offset(0.0, size.h2),
          ),
        ],
      ),
      child: child,
    );
  }
}
