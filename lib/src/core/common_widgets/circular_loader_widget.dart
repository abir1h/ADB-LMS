import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class CircularLoader extends StatelessWidget with AppTheme {
  final double? loaderSize;
  const CircularLoader({Key? key, this.loaderSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: loaderSize ?? size.h32,
        width: loaderSize ?? size.h32,
        child: CircularProgressIndicator(
          color: clr.appPrimaryColorGreen,
          strokeWidth: size.w2,
        ));
  }
}
