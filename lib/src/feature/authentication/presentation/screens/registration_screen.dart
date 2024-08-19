import 'dart:developer';

import 'package:adb_mobile/src/core/common_widgets/custom_button.dart';
import 'package:adb_mobile/src/core/constants/common_imports.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/common_widgets/custom_dropdown_widget.dart';
import '../../../../core/common_widgets/text_field_widget.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/constants/image_assets.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/constants/language.dart';
import '../../../discussion/presentation/service/discussion_screen_service.dart';
import '../services/registration_screen_service.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with AppTheme, Language, RegistrationScreenService {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    fetchDistrict();
  }

  void fetchDistrict() async {
    List<DropDownItem> items = await fetchDistrictDropdown();
    setState(() {
      districtItems = items;
    });
  }

  void _scrollToEnsureVisibility(BuildContext context) {
    // Ensures the dropdown remains visible when the keyboard opens
    if (_focusNode.hasFocus) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clr.scaffoldBackgroundColor,
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.h24),
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
                    SizedBox(height: size.h24),
                    AppTextFieldWithTitle(
                      title: StringData.firstNameText,
                      hintText: StringData.firstNameTextHint,
                      controller: TextEditingController(),
                    ),
                    SizedBox(height: size.h20),
                    AppTextFieldWithTitle(
                      title: StringData.lastNameText,
                      hintText: StringData.lastNameTextHint,
                      controller: TextEditingController(),
                    ),
                    SizedBox(height: size.h20),
                    AppTextFieldWithTitle(
                      title: StringData.phoneNumText,
                      hintText: StringData.phoneNumTexttHint,
                      controller: TextEditingController(),
                    ),
                    SizedBox(height: size.h20),
                    AppTextFieldWithTitle(
                      title: StringData.emailText,
                      hintText: StringData.emailTextHint,
                      controller: TextEditingController(),
                    ),
                    SizedBox(height: size.h20),
                    AppTextFieldWithTitle(
                      title: StringData.addressText,
                      hintText: StringData.addressTextHint,
                      controller: TextEditingController(),
                    ),
                    SizedBox(height: size.h20),
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
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: CustomDropdown.search(
                        hintText: 'Search for district',
                        items:
                            districtItems.map((item) => item.value!).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDistrictItem = districtItems
                                .firstWhere((item) => item.value == value);
                          });
                          print(
                              'Selected item: ${selectedDistrictItem?.value}');
                        },
                      ),
                    ),
                    SizedBox(height: size.h64),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void onClose() {
    // TODO: implement onClose
  }

  @override
  void onSubmit() {
    // TODO: implement onSubmit
  }
}
/*
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with AppTheme, Language, RegistrationScreenService {
  @override
  void initState() {
    super.initState();
     fetchDistrict();
  }
  void fetchDistrict() async {
    List<DropDownItem> items = await fetchDistrictDropdown();
    setState(() {
      districtItems = items;
    });
  }

  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clr.scaffoldBackgroundColor,
      resizeToAvoidBottomInset: true,
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
            CustomDropdown.search(
              hintText: 'Search for cuisines',

              items: districtItems.map((item) => item.value!).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDistrictItem = districtItems
                      .firstWhere((item) => item.value == value);
                });
                print('Selected item: ${selectedDistrictItem?.value}');
              },
            ),SizedBox(height: size.h64,)

*/
/*
            DropdownButton<DropDownItem>(
              isExpanded: true,
              dropdownColor: clr.whiteColor,
              elevation: 2,
              hint: const Text('Select District'),
              value: selectedDistrictItem,
              items: districtItems.map((DropDownItem item) {
                return DropdownMenuItem<DropDownItem>(
                  value: item,
                  child: Text(item.value!),
                );
              }).toList(),
              onChanged: (DropDownItem? newValue) {
                setState(() {
                  selectedDistrictItem = newValue;
                });
              },
            ),
*/ /*

*/
/*
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
*/ /*

          ],
        ),
      ),
    );
  }

  @override
  void onClose() {
    // TODO: implement onClose
  }

  @override
  void onSubmit() {
    // TODO: implement onSubmit
  }
}
*/
