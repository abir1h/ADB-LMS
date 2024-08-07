import 'package:flutter/material.dart';
import 'custom_shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  final Widget child;
  const ShimmerLoader({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(.5),
      highlightColor: Colors.grey.withOpacity(.1),
      enabled: true,
      child: child,
    );
  }
}
