import 'package:adb_mobile/src/core/common_widgets/custom_button.dart';
import 'package:adb_mobile/src/core/constants/common_imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/common_widgets/custom_dropdown_widget.dart';
import '../../../../core/common_widgets/text_field_widget.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/image_assets.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/constants/language.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with AppTheme, Language {
  @override
  void initState() {
    super.initState();
    // _callMethod();
  }

  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clr.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.h24,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Text(
                  "প্রশিক্ষণার্থীর রেজিস্ট্রেশন",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: size.textLarge,
                      color: clr.appPrimaryColorBlue),
                )),
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      CupertinoIcons.clear_fill,
                      color: clr.iconColorRed,
                    ))
              ],
            ),
            SizedBox(
              height: size.h24,
            ),
            AppTextFieldWithTitle(
              title: StringData.firstNameText,
              hintText: StringData.firstNameTextHint,
              controller: TextEditingController(),
            ),
            SizedBox(
              height: size.h20,
            ),
            AppTextFieldWithTitle(
              title: StringData.lastNameText,
              hintText: StringData.lastNameTextHint,
              controller: TextEditingController(),
            ),
            SizedBox(
              height: size.h20,
            ),
            AppTextFieldWithTitle(
              title: StringData.phoneNumText,
              hintText: StringData.phoneNumTexttHint,
              controller: TextEditingController(),
            ),
            SizedBox(
              height: size.h20,
            ),
            AppTextFieldWithTitle(
              title: StringData.emailText,
              hintText: StringData.emailTextHint,
              controller: TextEditingController(),
            ),
            SizedBox(
              height: size.h20,
            ),
            AppTextFieldWithTitle(
              title: StringData.addressText,
              hintText: StringData.addressTextHint,
              controller: TextEditingController(),
            ),
            SizedBox(
              height: size.h20,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: size.h10),
              child: Text(
                StringData.districtText,
                style: TextStyle(
                  fontSize: size.textSmall,
                  color: clr.textColorAppleBlack,
                ),
                textScaleFactor: 1,
              ),
            ),
            AppDropdown<String>(
              items: const ['No Item Found'],
              value: _selectedItem,
              onChanged: (value) {
                value == "No Item Found"
                    ? setState(() {
                         _selectedItem = null;
                      })
                    : setState(() {
                        _selectedItem = value;
                      });
              },
              hint: StringData.districtTextHint,
              icon: const Icon(Icons.arrow_drop_down),
              dropdownColor: Colors.white,
              hintStyle: const TextStyle(color: Colors.grey),
              itemStyle: const TextStyle(color: Colors.black),
              borderColor: Colors.grey.withOpacity(.2),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
            ),
            CustomButton(
              onTap: () {},
              title: StringData.enterText,
              bgColor: clr.appPrimaryColorBlue,
              boxShadow: [
                BoxShadow(
                  color: clr.blackColor.withOpacity(.3),
                  blurRadius: size.r4,
                  offset: Offset(0.0, size.r1 * 5),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}