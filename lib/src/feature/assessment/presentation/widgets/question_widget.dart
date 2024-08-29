import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/common_widgets/image_preview.dart';
import '../../../../core/constants/common_imports.dart';

class QuestionWidget extends StatelessWidget with AppTheme, ImagePreviewDialog {
  final String questionNo;
  final String questionText;
  final String questionImage;
  final String questionDescription;
  final String questionMarks;
  final Widget child;
  const QuestionWidget({
    Key? key,
    required this.questionNo,
    required this.questionText,
    this.questionImage = "",
    this.questionDescription = "",
    required this.questionMarks,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: clr.shadeWhiteColor2,
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0,
              color: clr.blackColor.withOpacity(.2))
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(TextSpan(
              text: "প্রশ্ন ${questionNo.trim()}. ",
              style: TextStyle(
                color: clr.blackColor,
                fontSize: size.textSmall,
                fontWeight: FontWeight.w700,
                fontFamily: StringData.fontFamilyPoppins,
              ),
              children: [
                TextSpan(
                  text: questionText.trim(),
                  style: TextStyle(
                    color: clr.blackColor,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins,
                  ),
                ),
                TextSpan(
                  text: "  [$questionMarks] ",
                  style: TextStyle(
                    color: clr.blackColor,
                    fontSize: size.textSmall,
                    fontWeight: FontWeight.w500,
                    fontFamily: StringData.fontFamilyPoppins,
                  ),
                ),
              ])),
          if (questionImage.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: size.h4),
              child: GestureDetector(
                  onTap: () {
                    ImagePreviewDialog.showImagePreview(context, questionImage);
                  },
                  child: Center(
                      child: CachedNetworkImage(
                    fit: BoxFit.fitWidth,
                    imageUrl: ApiCredential.mediaBaseUrl + questionImage,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ))),
            ),
          if (questionDescription.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: size.h4),
              child: Text(
                questionDescription,
                style: TextStyle(
                  color: clr.gapStrokeGrey,
                  fontSize: size.textXXSmall,
                  fontWeight: FontWeight.w400,
                  fontFamily: StringData.fontFamilyRoboto,
                ),
              ),
            ),
          SizedBox(height: size.h10),
          Flexible(
            child: child,
          ),
        ],
      ),
    );
  }
}
