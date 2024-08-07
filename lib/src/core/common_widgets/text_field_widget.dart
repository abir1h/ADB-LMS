import 'package:flutter/material.dart';

import '../constants/strings.dart';
import '../constants/app_theme.dart';

class AppTextFieldWithIcon extends StatelessWidget with AppTheme {
  final bool readOnly;
  final String title;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final bool autoMaxLine;
  final Widget? prefixIcon;

  AppTextFieldWithIcon({
    Key? key,
    this.readOnly = false,
    this.title = '',
    required this.hintText,
    required this.controller,
    this.focusNode,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.autoMaxLine = false,
    this.prefixIcon ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      readOnly: readOnly,
      autoMaxLine: autoMaxLine,
      controller: controller,
      hintText: hintText,
      obscureText: obscureText,
      keyboardType: keyboardType,
      focusNode: focusNode,

    );
  }
}



class AppTextField extends StatefulWidget {
  final bool readOnly;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final bool autoMaxLine;
  final VoidCallback? onTaped;
  final FormFieldValidator<String>? validator;

  const AppTextField({
    Key? key,
    this.readOnly = false,
    required this.hintText,
    required this.controller,
    this.focusNode,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.autoMaxLine = false,
    this.validator,
    this.onTaped,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> with AppTheme {
  late bool _obscureText;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final focusNode = widget.focusNode ?? FocusNode();

    return Container(
      height: size.h56,
      width: double.infinity,
      decoration: BoxDecoration(
        color: clr.fromBoxFillColor,
        borderRadius: BorderRadius.circular(size.r8),

      ),
      child: Center(
        child: TextFormField(
          onTap: widget.onTaped,
          readOnly: widget.readOnly,
          controller: widget.controller,
          focusNode: focusNode,
          cursorRadius: const Radius.circular(100),
          cursorColor: clr.appPrimaryColorBlue,
          cursorWidth: size.w2,
          autocorrect: false,
          maxLines: widget.autoMaxLine ? null : 1,
          keyboardType: widget.keyboardType,
          obscureText: _obscureText,
          validator: widget.validator,
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: clr.appPrimaryColorBlue,
                width: size.w1,
              ),
              borderRadius: BorderRadius.all(Radius.circular(size.w8)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: clr.boxStrokeColor,
                width: size.w1,
              ),
              borderRadius: BorderRadius.all(Radius.circular(size.w8)),
            ),
            hintText: widget.hintText,
            contentPadding: EdgeInsets.symmetric(horizontal: size.w12),
            hintStyle: TextStyle(
              color: clr.placeHolderTextColorGray,
              fontSize: size.textSmall,
              fontWeight: FontWeight.w400,
              fontFamily: StringData.fontFamilyRoboto,
            ),
            suffixIcon: _obscureText==true?IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: clr.placeHolderTextColorGray,
              ),
              onPressed: _toggleObscureText,
            ):SizedBox(),
            prefixIcon: widget.prefixIcon,
          ),
          style: TextStyle(
            color: clr.textColorBlack,
            fontSize: size.textSmall,
            fontWeight: FontWeight.w400,
            fontFamily: StringData.fontFamilyRoboto,
          ),
        ),
      ),
    );
  }
}
