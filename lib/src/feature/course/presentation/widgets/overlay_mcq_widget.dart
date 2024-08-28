import 'package:flutter/material.dart';

import '../../../../core/utility/app_label.dart';
import '../../../../core/constants/common_imports.dart';
import '../../domain/entities/popup_quiz_data_model.dart';

class OverlayMCQWidget<T> extends StatelessWidget with AppTheme {
  final PopupQuizDataEntity data;
  final List<Widget> options;
  final VoidCallback onTapSkip, onTapSubmit;
  const OverlayMCQWidget(
      {super.key,
      required this.options,
      required this.data,
      required this.onTapSkip,
      required this.onTapSubmit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.w24 + size.w1, vertical: size.h12),
      decoration: BoxDecoration(color: clr.whiteShade.withOpacity(.9)),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'প্রশ্ন ১:',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: size.textXSmall,
                    fontFamily: StringData.fontFamilyRoboto,
                    color: clr.blackText),
              ),
              SizedBox(
                width: size.w16,
              ),
              Expanded(
                child: Text(
                  data.question,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: size.textXXSmall,
                      fontFamily: StringData.fontFamilyRoboto,
                      color: clr.blackText),
                ),
              )
            ],
          ),
          SizedBox(
            height: size.h12,
          ),
          Expanded(
            child: GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Adjust the number of columns as needed
                  crossAxisSpacing: size.h8, // Horizontal space between items
                  mainAxisSpacing: size.h1,
                  childAspectRatio: 3 // Vertical space between items
                  ),
              children: options,
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            GestureDetector(
              onTap: onTapSkip,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.w12, vertical: size.h2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size.r50),
                    color: clr.placeHolderTextColorGray),
                child: Text(
                  label(e: "Skip", b: "স্কিপ"),
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: size.textXSmall,
                      fontFamily: StringData.fontFamilyRoboto,
                      color: clr.textColorAppleBlack),
                ),
              ),
            ),
            SizedBox(
              width: size.w8,
            ),
            GestureDetector(
              onTap: onTapSubmit,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.w12, vertical: size.h2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size.r50),
                    color: clr.appPrimaryColorBlue),
                child: Text(
                  label(e: 'Submit', b: 'সাবমিট'),
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: size.textXSmall,
                      fontFamily: StringData.fontFamilyRoboto,
                      color: clr.whiteColor),
                ),
              ),
            ),
          ]),
          SizedBox(
            height: size.h20,
          ),
        ],
      ),
    );
  }
}

///MCQ Options
class OverlayMCQAnswerOptionWidget extends StatefulWidget {
  final String value;
  final bool isSelected;
  final VoidCallback onTap;
  const OverlayMCQAnswerOptionWidget(
      {Key? key,
      required this.value,
      required this.isSelected,
      required this.onTap})
      : super(key: key);

  @override
  State<OverlayMCQAnswerOptionWidget> createState() =>
      _OverlayMCQAnswerOptionWidgetState();
}

class _OverlayMCQAnswerOptionWidgetState
    extends State<OverlayMCQAnswerOptionWidget> with AppTheme {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            widget.isSelected
                ? Icons.check_box_rounded
                : Icons.check_box_outline_blank,
            size: MediaQuery.of(context).orientation == Orientation.portrait
                ? size.r24
                : size.r50,
            color: widget.isSelected ? clr.appPrimaryColorBlue : clr.greyColor,
          ),
          SizedBox(width: size.w12),
          if (widget.value.isNotEmpty)
            Expanded(
              child: Text(
                widget.value,
                maxLines: 2,
                style: TextStyle(
                    color: clr.blackColor,
                    fontSize: size.textXXSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins),
              ),
            ),
        ],
      ),
    );
  }
}
