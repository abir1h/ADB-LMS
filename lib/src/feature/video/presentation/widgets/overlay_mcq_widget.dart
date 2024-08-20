// import 'package:flutter/material.dart';
//
// import '../../../../core/utility/app_label.dart';
// import '../../../course/domain/entities/video_qustion_data_entity.dart';
// import '../../../../core/constants/common_imports.dart';
//
// class OverlayMCQWidget<T> extends StatelessWidget with AppTheme {
//   final List<T> items;
//   final VideoQuestionDataEntity data;
//   final VoidCallback onTapSkip, onTapSubmit;
//   final Widget Function(BuildContext context, int index, T item) builder;
//   const OverlayMCQWidget(
//       {super.key,
//       required this.items,
//       required this.builder,
//       required this.data,
//       required this.onTapSkip,
//       required this.onTapSubmit});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//           horizontal: size.w24 + size.w1, vertical: size.h12),
//       decoration: BoxDecoration(color: clr.whiteShade.withOpacity(.9)),
//       child: Column(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'প্রশ্ন ১:',
//                 style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: size.textXSmall,
//                     fontFamily: StringData.fontFamilyRoboto,
//                     color: clr.blackText),
//               ),
//               SizedBox(
//                 width: size.w16,
//               ),
//               Expanded(
//                 child: Text(
//                   data.questionText,
//                   style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       fontSize: size.textXSmall,
//                       fontFamily: StringData.fontFamilyRoboto,
//                       color: clr.blackText),
//                 ),
//               )
//             ],
//           ),
//           SizedBox(
//             height: size.h12,
//           ),
//           /*  ListView.separated(
//             shrinkWrap: true,
//             itemCount: items.length,
//             physics: const NeverScrollableScrollPhysics(),
//             itemBuilder: (context, index) =>
//                 builder(context, index, items[index]),
//             separatorBuilder: (context, index) {
//               return SizedBox(height: size.h12);
//             },
//           ),*/
//           Expanded(
//             child: GridView.builder(
//               shrinkWrap: true,
//               itemCount: items.length,
//               physics: const NeverScrollableScrollPhysics(),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2, // Adjust the number of columns as needed
//                   crossAxisSpacing: size.h8, // Horizontal space between items
//                   mainAxisSpacing: size.h1,
//                   childAspectRatio: 3 // Vertical space between items
//                   ),
//               itemBuilder: (context, index) {
//                 return builder(context, index, items[index]);
//               },
//             ),
//           ),
//           Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//             GestureDetector(
//               onTap: onTapSkip,
//               child:  Container(
//                 padding:
//                 EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h2),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(size.r50),
//                     color: clr.placeHolderTextColorGray),
//                 child: Text(
//                   label(e: "Skip", b: "স্কিপ"),
//                   style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       fontSize: size.textXSmall,
//                       fontFamily: StringData.fontFamilyRoboto,
//                       color: clr.textColorAppleBlack),
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: size.w8,
//             ),
//             GestureDetector(
//               onTap: onTapSubmit,
//               child:  Container(
//                 padding:
//                 EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h2),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(size.r50),
//                     color: clr.appPrimaryColorGreen),
//                 child: Text(
//                   label(e: 'Submit', b: 'সাবমিট'),
//                   style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       fontSize: size.textXSmall,
//                       fontFamily: StringData.fontFamilyRoboto,
//                       color: clr.whiteColor),
//                 ),
//               ),
//             ),
//
//           ]),
//           SizedBox(
//             height: size.h20,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// ///MCQ Options
// class OverlayMCQAnswerOptionWidget extends StatefulWidget {
//   final String value;
//   final bool isSelected;
//   final VoidCallback onTap;
//   const OverlayMCQAnswerOptionWidget(
//       {Key? key,
//       required this.value,
//       required this.isSelected,
//       required this.onTap})
//       : super(key: key);
//
//   @override
//   State<OverlayMCQAnswerOptionWidget> createState() =>
//       _OverlayMCQAnswerOptionWidgetState();
// }
//
// class _OverlayMCQAnswerOptionWidgetState
//     extends State<OverlayMCQAnswerOptionWidget> with AppTheme {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onTap,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Icon(
//             widget.isSelected
//                 ? Icons.check_box_rounded
//                 : Icons.check_box_outline_blank,
//             size: MediaQuery.of(context).orientation == Orientation.portrait ? size.r24 : size.r50,
//             color: widget.isSelected ? clr.appPrimaryColorGreen : clr.greyColor,
//           ),
//           SizedBox(width: size.w12),
//           if (widget.value.isNotEmpty)
//             Expanded(
//               child: Text(
//                 widget.value,
//                 maxLines: 2,
//                 style: TextStyle(
//                     color: clr.blackColor,
//                     fontSize: size.textSmall,
//                     fontWeight: FontWeight.w500,
//                     fontFamily: StringData.fontFamilyPoppins),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
