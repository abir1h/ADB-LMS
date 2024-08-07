// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lottie/lottie.dart';
//
// import '../constants/common_imports.dart';
//
// class EmptyWidget extends StatelessWidget with AppTheme {
//   final BoxConstraints? constraints;
//   final String message;
//   final double? offset;
//   final IconData icon;
//   const EmptyWidget(
//       {Key? key,
//       this.constraints,
//       required this.message,
//       this.icon = Icons.weekend_outlined,
//       this.offset})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         height: constraints!.maxHeight - (offset ?? 242.w),
//         child: Padding(
//             padding: EdgeInsets.all(size.h24),
//             child: Center(
//               child: Column(mainAxisSize: MainAxisSize.min, children: [
//                 Lottie.asset(ImageAssets.animEmpty, height: size.h64 * 3),
//                 SizedBox(height: size.h8),
//                 Text(
//                   message,
//                   style: TextStyle(
//                     color: clr.blackColor,
//                     fontSize: size.textSmall,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ]),
//             )));
//   }
// }
