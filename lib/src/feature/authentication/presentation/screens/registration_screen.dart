import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/constants/common_imports.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/select_district_bottomsheet.dart';
import '../widgets/select_institution_bottomsheet.dart';
import '../../../../core/common_widgets/custom_button.dart';
import '../../../../core/common_widgets/text_field_widget.dart';
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
  bool showDistrictError = false;
  bool showGenderError = false;
  bool showLoanError = false;
  bool showInstitutionError = false;
  bool formValidate = false;
  @override
  void initState() {
    super.initState();
    fetchDistrict();
    fetchInstitution();
  }

  void _validateDropdowns() {
    setState(() {
      showDistrictError = selectedDistrictItem == null;
      showGenderError = selectedGenderItem == null;
      showLoanError =
          selectedLoanItem == null && selectedGenderItem?.id == "Female";
      showInstitutionError =
          selectedInstitutionItem == null && selectedLoanItem?.id == 'true';
    });
  }

  void fetchDistrict() async {
    List<DropDownItem> items = await fetchDistrictDropdown();
    setState(() {
      districtItems = items;
    });
  }

  void fetchInstitution() async {
    List<DropDownItem> items = await fetchInstitutionDropDown();
    setState(() {
      institutionItems = items;
    });
  }

  void _scrollToEnsureVisibility(BuildContext context) {
    // Ensures the dropdown remains visible when the keyboard opens
    if (_focusNode.hasFocus) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  String? _selectedItem;
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clr.scaffoldBackgroundColor2,
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Form(
                  key: formkey,
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
                        title: "${StringData.firstNameText}*",
                        hintText: StringData.firstNameTextHint,
                        controller: firstName,

                        validator: (v) {
                          return v!.isEmpty ? "Please Enter FirstName" : null;
                        },
                      ),
                      SizedBox(height: size.h20),
                      AppTextFieldWithTitle(
                        title: StringData.lastNameText,

                        hintText: StringData.lastNameTextHint,
                        controller: lastName,
                      ),
                      SizedBox(height: size.h20),
                      AppTextFieldWithTitle(
                        title: "${StringData.usernameText}*",
                        hintText: StringData.userNameHint,
                        controller: userName,
                        validator: (v) {
                          return v!.isEmpty ? "Please Enter User Name" : null;
                        },
                      ),
                      SizedBox(height: size.h20),
                      AppTextFieldWithTitle(
                        title: "${StringData.phoneNumText}*",
                        hintText: StringData.phoneNumTexttHint,
                        keyboardType: TextInputType.number,

                        controller: phone,
                        validator: (v) {
                          return v!.isEmpty ? "Please Enter Phone" : null;
                        },
                      ),
                      SizedBox(height: size.h20),
                      AppTextFieldWithTitle(
                        title: StringData.emailText,
                        hintText: StringData.emailTextHint,

                        controller: email,
                      ),
                      SizedBox(height: size.h20),
                      AppTextFieldWithTitle(
                        title: "${StringData.passwordText}*",
                        hintText: StringData.passwordTextHint,

                        obscureText: true,

                        controller: password,
                        validator: (v) {
                          return v!.isEmpty ? "Please Enter Password" : null;
                        },
                      ),
                      SizedBox(height: size.h20),
                      AppTextFieldWithTitle(
                        title: StringData.addressText,
                        hintText: StringData.addressTextHint,

                        controller: address,
                      ),
                      SizedBox(height: size.h20),
                      Padding(
                        padding: EdgeInsets.only(bottom: size.h10),
                        child: Text(
                          "${StringData.districtText}*",
                          style: TextStyle(
                            fontSize: size.textSmall,
                            color: clr.textColorAppleBlack,
                          ),
                          textScaleFactor: 1,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return SelectDistrictBottomSheet(
                                context2: context,
                                items: districtItems,
                              );
                            },
                          ).then((v) {
                            setState(() {
                              selectedDistrictItem = v;

                            });
                            // print(selectedDistrictItem!.value!);
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: size.h12, horizontal: size.w12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: clr.whiteColor),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                selectedDistrictItem != null
                                    ? selectedDistrictItem!.value!
                                    : "জেলা নির্বাচন করুন",
                                style: TextStyle(
                                    color: selectedDistrictItem != null
                                        ? clr.blackColor
                                        : clr.greyColor,
                                    fontSize: size.textSmall,
                                    fontWeight: FontWeight.w500),
                              )),
                              const Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      ),
                      if (showDistrictError)
                        Text(
                          "Field Required",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: clr.iconColorRed),
                        ),
                      SizedBox(
                        height: size.h20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: size.h10),
                        child: Text(
                          'লিঙ্গ (Gender)',
                          style: TextStyle(
                            fontSize: size.textSmall,
                            color: clr.textColorAppleBlack,
                          ),
                          textScaleFactor: 1,
                        ),
                      ),
                      SizedBox(
                        height: size.h4,
                      ),
                      SelectorDropDownList<DropDownItem>(
                        onLoadData: () async =>genderItems,
                        onGenerateTitle: (x)=> x.value!,
                        onSelected: (value){
                          setState(() {
                            selectedGenderItem = value;
                            gender = true;
                          });
                        },
                      ),SizedBox(
                        height: size.h20,
                      ),
/*
                      Container(
                        color: clr.whiteColor,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<DropDownItem>(
                            isExpanded: true,
                            dropdownColor: clr.whiteColor,
                            elevation: 2,
                            hint:  Text('   লিঙ্গ নির্বাচন করুন',style:  TextStyle(
                                color:  selectedGenderItem!= null
                                    ? clr.blackColor
                                    : clr.greyColor,
                                fontSize: size.textSmall,
                                fontWeight: FontWeight.w500),),
                            value: selectedGenderItem,
                            items: genderItems.map((DropDownItem item) {
                              return DropdownMenuItem<DropDownItem>(
                                value: item,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(item.value!),
                                ),
                              );
                            }).toList(),
                            onChanged: (DropDownItem? newValue) {
                              setState(() {
                                selectedGenderItem = newValue;
                                gender = true;
                              });
                            },
                            onTap: (){
                              FocusScope.of(context).unfocus();
                            },
                          ),
                        ),
                      ),
*/
                      if (showGenderError)
                        Text(
                          "Field Required",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: clr.iconColorRed),
                        ),
                      SizedBox(
                        height: size.h20,
                      ),
                      selectedGenderItem != null
                          ? selectedGenderItem?.id == "Female"
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(bottom: size.h10),
                                      child: Text(
                                        'আপনি কি আগে কোন ঋণ নিয়েছেন? (Did you took any loan before?)*"',
                                        style: TextStyle(
                                          fontSize: size.textSmall,
                                          color: clr.textColorAppleBlack,
                                        ),
                                        textScaleFactor: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.h4,
                                    ),  SelectorDropDownList<DropDownItem>(
                                      onLoadData: () async =>loanItems,
                                      onGenerateTitle: (x)=> x.value!,
                                      onSelected: (value){
                                        setState(() {
                                          selectedLoanItem = value;
                                        });
                                      },
                                    ),
/*
                                    Container(
                                      color: clr.whiteColor,
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<DropDownItem>(
                                          isExpanded: true,
                                          // underline: SizedBox(),
                                          dropdownColor: clr.whiteColor,
                                          elevation: 2,
                                          hint:  Text('  নির্বাচন করুন',style:  TextStyle(
                                              color: selectedLoanItem != null
                                                  ? clr.blackColor
                                                  : clr.greyColor,
                                              fontSize: size.textSmall,
                                              fontWeight: FontWeight.w500),),
                                          value: selectedLoanItem,
                                          items: loanItems
                                              .map((DropDownItem item) {
                                            return DropdownMenuItem<
                                                DropDownItem>(
                                              value: item,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(item.value!),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (DropDownItem? newValue) {
                                            setState(() {
                                              selectedLoanItem = newValue;
                                            });
                                          }, onTap: (){
                                          FocusScope.of(context).unfocus();
                                        },
                                        ),
                                      ),
                                    ),
*/
                                    if (showLoanError)
                                      Text(
                                        "Field Required",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: clr.iconColorRed),
                                      ),
                                    SizedBox(height: size.h10,),
                                    selectedLoanItem != null
                                        ? selectedLoanItem?.id == 'true'
                                            ? Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: size.h10),
                                                    child: Text(
                                                      "কোন প্রতিষ্ঠান থেকে ঋণ নিয়েছেন? (Please mention the name of organization from where you took your loan before)*",
                                                      style: TextStyle(
                                                        fontSize:
                                                            size.textSmall,
                                                        color: clr
                                                            .textColorAppleBlack,
                                                      ),
                                                      textScaleFactor: 1,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {FocusScope.of(context).unfocus();
                                                    showModalBottomSheet(
                                                        context: context,
                                                        isScrollControlled:
                                                            true,
                                                        builder: (BuildContext
                                                            context) {
                                                          return SelectInstitutionBottomsheet(
                                                            context2: context,
                                                            items:
                                                                institutionItems,
                                                          );
                                                        },
                                                      ).then((v) {
                                                        setState(() {
                                                          selectedInstitutionItem =
                                                              v;
                                                        });
                                                        // print(selectedDistrictItem!.value!);
                                                      });
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical:
                                                                  size.h12,
                                                              horizontal:
                                                                  size.w12),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          color:
                                                              clr.whiteColor),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                            selectedInstitutionItem !=
                                                                    null
                                                                ? selectedInstitutionItem!
                                                                    .value!
                                                                : "নির্বাচন করুন",
                                                            style: TextStyle(
                                                                color: selectedInstitutionItem !=
                                                                        null
                                                                    ? clr
                                                                        .blackColor
                                                                    : clr
                                                                        .greyColor,
                                                                fontSize: size
                                                                    .textSmall,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )),
                                                          const Icon(Icons
                                                              .arrow_drop_down)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  if (showInstitutionError)
                                                    Text(
                                                      "Field Required",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              clr.iconColorRed),
                                                    ),
                                                ],
                                              )
                                            : Text(
                                                "দুঃখিত আমাদের প্রশিক্ষণ শুধুমাত্র নারী উদ্যোক্তাদের জন্য যারা পূর্বে ঋণ গ্রহণ করেছেন",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: size.textSmall),
                                              )
                                        : const SizedBox()
                                  ],
                                )
                              : Text(
                                  "দুঃখিত আমাদের প্রশিক্ষণ শুধুমাত্র নারী উদ্যোক্তাদের জন্য যারা পূর্বে ঋণ গ্রহণ করেছেন",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                      fontSize: size.textSmall),
                                )
                          : const SizedBox(),
                      SizedBox(height: size.h24),
                      CustomButton(
                        onTap: () {
                          if (formkey.currentState!.validate()) {
                            _validateDropdowns();
                            if (!showDistrictError &&
                                !showGenderError &&
                                !showLoanError &&
                                !showInstitutionError) {
                              signUP(context);
                              print('Form is valid');
                              // Proceed with submission
                            }
                          }
                        },
                        title: StringData.regText2,
                        bgColor: clr.appPrimaryColorBlue,
                        boxShadow: [
                          BoxShadow(
                            color: clr.blackColor.withOpacity(.3),
                            blurRadius: size.r4,
                            offset: Offset(0.0, size.r1 * 5),
                          ),
                        ],
                      ),
                      SizedBox(height: size.h64),
                    ],
                  ),
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

  @override
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }
}
