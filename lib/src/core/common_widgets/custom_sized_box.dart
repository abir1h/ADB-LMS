import 'package:flutter/material.dart';

class CustomSizedBox extends SizedBox {
  const CustomSizedBox({super.key,
    double width = 0.0,
    double height = 0.0,
    Widget? child,
  }) : super(
    width: width,
    height: height,
    child: child,
  );
}
