import 'package:flutter/material.dart';

import '../constants/common_imports.dart';
import '../utility/app_label.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final int minimumTextLengthToFold;
  const ExpandableText(
      {Key? key,
      required this.text,
      required this.style,
      required this.minimumTextLengthToFold})
      : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText>
    with AppTheme, Language {
  bool isFoldable = false;
  bool isFolded = true;

  @override
  void initState() {
    isFoldable = widget.text.length > widget.minimumTextLengthToFold;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: widget.text.substring(
            0,
            isFoldable == true && isFolded == true
                ? widget.minimumTextLengthToFold
                : null),
        children: [
          if (isFoldable && isFolded) const TextSpan(text: "..."),
          if (isFoldable && isFolded)
            WidgetSpan(
              child: GestureDetector(
                onTap: _showMore,
                child: Text(
                  label(e: en.seeMore, b: bn.seeMore),
                  style: widget.style.copyWith(
                      color: clr.appPrimaryColorGreen,
                      fontSize: size.textXSmall),
                ),
              ),
            ),
          if (isFoldable && !isFolded)
            WidgetSpan(
              child: GestureDetector(
                onTap: _showLess,
                child: Text(
                  label(e: en.seeLess, b: bn.seeLess),
                  style: widget.style.copyWith(
                      color: clr.appPrimaryColorGreen,
                      fontSize: size.textXSmall),
                ),
              ),
            ),
        ],
      ),
      style: widget.style,
      textAlign: TextAlign.justify,
    );
  }

  void _showMore() {
    if (isFoldable && mounted) {
      setState(() {
        isFolded = false;
      });
    }
  }

  void _showLess() {
    if (isFoldable && mounted) {
      setState(() {
        isFolded = true;
      });
    }
  }
}
