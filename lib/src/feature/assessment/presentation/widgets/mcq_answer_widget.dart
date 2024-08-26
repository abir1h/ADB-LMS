import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/common_imports.dart';

class MCQWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) builder;
  const MCQWidget({super.key, required this.items, required this.builder});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: items.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => builder(context, index, items[index]),
      separatorBuilder: (context, index) {
        return SizedBox(height: size.h12);
      },
    );
  }
}

///MCQ Options
class MCQAnswerOptionWidget extends StatefulWidget {
  final String value;
  final String imageValue;
  final bool isSelected;
  final VoidCallback onTap;
  const MCQAnswerOptionWidget(
      {Key? key,
      required this.value,
      required this.imageValue,
      required this.isSelected,
      required this.onTap})
      : super(key: key);

  @override
  State<MCQAnswerOptionWidget> createState() => _MCQAnswerOptionWidgetState();
}

class _MCQAnswerOptionWidgetState extends State<MCQAnswerOptionWidget>
    with AppTheme {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.w12, vertical: size.h12),
        decoration: BoxDecoration(
            color: widget.isSelected ? clr.drawerFillColor : clr.whiteColor,
            borderRadius: BorderRadius.circular(size.r8),
            border: Border.all(color: clr.boxStrokeColor, width: size.r1)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              widget.isSelected
                  ? Icons.check_box_rounded
                  : Icons.check_box_outline_blank,
              size: size.r24,
              color: widget.isSelected
                  ? clr.appPrimaryColorBlue
                  : clr.gapStrokeGrey,
            ),
            SizedBox(width: size.w24),
            if (widget.imageValue.isNotEmpty)
              CachedNetworkImage(
                fit: BoxFit.fitWidth,
                imageUrl: ApiCredential.mediaBaseUrl + widget.imageValue,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            if (widget.value.isNotEmpty)
              Expanded(
                child: Text(
                  widget.value,
                  style: TextStyle(
                      color: clr.blackColor,
                      fontSize: size.textSmall,
                      fontWeight: FontWeight.w500,
                      fontFamily: StringData.fontFamilyPoppins),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
