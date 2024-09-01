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
  final Widget? prefixIcon;
  final FormFieldValidator<String>? validator;

  AppTextFieldWithTitle({
    super.key,
    this.readOnly = false,
    this.title = '',
    required this.hintText,
    required this.controller,
    this.focusNode,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.autoMaxLine = false,
    this.prefixIcon,
    this.validator,
  });

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
          validator: validator,
          prefixIcon: null,
        ),
      ],
    );
  }
}

class AppTextField extends StatefulWidget {
  final bool readOnly;
  final String hintText;
  final bool? obscureText;
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
    this.obscureText,
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

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText ?? false;
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final focusNode = widget.focusNode ?? FocusNode();

    return TextFormField(
      onTap: widget.onTaped,
      readOnly: widget.readOnly,
      controller: widget.controller,
      cursorRadius: const Radius.circular(100),
      cursorColor: clr.appPrimaryColorBlue,
      cursorWidth: size.w2,
      autocorrect: false,
      maxLines: widget.autoMaxLine ? null : 1,
      keyboardType: widget.keyboardType,
      obscureText: _obscureText,
      validator: widget.validator,

/*
      decoration: InputDecoration(
        border: InputBorder.none,
        floatingLabelAlignment: FloatingLabelAlignment.center,
          filled: true, // Enable filling the background
          fillColor: Colors.white,

        hintText: widget.hintText,

        //bacboncontentPadding: EdgeInsets.symmetric(horizontal: size.w12),
        hintStyle: TextStyle(
          color: clr.placeHolderTextColorGray,
          fontSize: size.textSmall,
          fontWeight: FontWeight.w400,
          fontFamily: StringData.fontFamilyRoboto,
        ),
        suffixIcon: widget.obscureText == true
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: clr.placeHolderTextColorGray,
                ),
                onPressed: _toggleObscureText,
              )
            : const SizedBox(),
        prefixIcon: widget.prefixIcon ?? null,
      ),
*/
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: clr.greyColor,
          ),
        ),filled: true, // Enable filling the background
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: clr.greyColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: clr.appPrimaryColorBlue,
          ),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: clr.placeHolderTextColorGray,
          fontSize: size.textSmall,
          fontWeight: FontWeight.w400,
          fontFamily: StringData.fontFamilyRoboto,
        ),
        suffixIcon: widget.obscureText == true
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: clr.placeHolderTextColorGray,
          ),
          onPressed: _toggleObscureText,
        )
            : null,
        prefixIcon: widget.prefixIcon,
      ),

      style: TextStyle(
        color: clr.textColorBlack,
        fontSize: size.textSmall,
        fontWeight: FontWeight.w400,
        fontFamily: StringData.fontFamilyRoboto,
      ),
    );
  }
}
