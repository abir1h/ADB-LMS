import 'package:flutter/material.dart';

import '../constants/strings.dart';
import '../constants/app_theme.dart';

class AppTextFieldWithTitle extends StatelessWidget with AppTheme {
  final bool readOnly;
  final String title;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final bool autoMaxLine;

  AppTextFieldWithTitle({
    Key? key,
    this.readOnly = false,
    this.title = '',
    required this.hintText,
    required this.controller,
    this.focusNode,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.autoMaxLine = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != '')
          Padding(
            padding: EdgeInsets.only(bottom: size.h4),
            child: Text(
              title,
              style: TextStyle(
                fontSize: size.textSmall,
                color: clr.textColorAppleBlack,
              ),
              textScaleFactor: 1,
            ),
          ),
        AppTextField(
          readOnly: readOnly,
          autoMaxLine: autoMaxLine,
          controller: controller,
          hintText: hintText,
          obscureText: obscureText,
          keyboardType: keyboardType,
          focusNode: focusNode,
        ),
      ],
    );
  }
}

class AppTextField extends StatefulWidget {
  final bool readOnly;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final bool autoMaxLine;
  final VoidCallback? onTaped;
  final FormFieldValidator<String>? validator;

  const AppTextField(
      {Key? key,
      this.readOnly = false,
      required this.hintText,
      required this.controller,
      this.focusNode,
      this.obscureText = false,
      this.suffixIcon,
      this.keyboardType = TextInputType.text,
      this.autoMaxLine = false,
      this.validator,
      this.onTaped})
      : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> with AppTheme {
  // bool _hasFocused = false;
  FocusNode focusNode = FocusNode();

  // @override
  // void initState() {
  //   super.initState();
  //
  //   _hasFocused = focusNode.hasFocus;
  //   focusNode.addListener(() {
  //     _changeBorder();
  //   });
  // }
  //
  // void _changeBorder() {
  //   setState(() {
  //     _hasFocused = focusNode.hasFocus;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.h40,
      width: double.infinity,
      // padding: EdgeInsets.symmetric(horizontal: size.s12, vertical: 0),
      decoration: BoxDecoration(color: clr.fromBoxFillColor
          // borderRadius: BorderRadius.circular(size.s8),
          // border: Border.all(
          //   color: _hasFocused
          //       ? HexColor(HexColorCode.appPrimaryColor)
          //       : HexColor(HexColorCode.hintTextColor),
          //   width: size.s1,
          // ),
          ),
      child: Center(
        child: TextFormField(
          onTap: widget.onTaped,
          readOnly: widget.readOnly,
          controller: widget.controller,
          focusNode: focusNode,
          cursorRadius: const Radius.circular(100),
          cursorColor: clr.appPrimaryColorGreen,
          cursorWidth: size.w2,
          autocorrect: false,
          maxLines: (widget.autoMaxLine) ? null : 1,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          validator: widget.validator,
          decoration: InputDecoration(
            // isDense: true,
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: clr.appPrimaryColorGreen, width: size.w1),
              borderRadius: BorderRadius.all(Radius.circular(size.w8)),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: clr.boxStrokeColor, width: size.w1),
                borderRadius: BorderRadius.all(Radius.circular(size.w8))),
            hintText: widget.hintText,
            contentPadding: EdgeInsets.symmetric(horizontal: size.w12),
            hintStyle: TextStyle(
                color: clr.placeHolderTextColorGray,
                fontSize: size.textSmall,
                fontWeight: FontWeight.w400,
                fontFamily: StringData.fontFamilyRoboto),
            suffixIcon: widget.suffixIcon,
          ),
          style: TextStyle(
              color: clr.textColorBlack,
              fontSize: size.textSmall,
              fontWeight: FontWeight.w400,
              fontFamily: StringData.fontFamilyRoboto),
        ),
      ),
    );
  }
}
