import 'package:adb_mobile/src/core/common_widgets/app_dropdown_widget.dart';
import 'package:adb_mobile/src/core/common_widgets/custom_toasty.dart';
import 'package:adb_mobile/src/core/constants/app_theme.dart';
import 'package:adb_mobile/src/feature/certificate/presentation/service/certificate_screen_service.dart';
import 'package:adb_mobile/src/feature/course/domain/entities/course_overview_data_entity.dart';
import 'package:adb_mobile/src/feature/discussion/presentation/service/discussion_screen_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../profile/domain/entities/user_data_entity.dart';

class NameChangeButtomSheet extends StatefulWidget {
  final BuildContext context2;
  const NameChangeButtomSheet({
    Key? key,
    required this.context2,
  }) : super(key: key);

  @override
  _NameChangeButtomSheetState createState() => _NameChangeButtomSheetState();
}

class _NameChangeButtomSheetState extends State<NameChangeButtomSheet>
    with AppTheme, CertificateListScreenService {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context)
            .viewInsets
            .bottom, // Adjust the padding when the keyboard is open
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(size.r16),
              topRight: Radius.circular(size.r16),
            ),
            color: clr.whiteColor,
          ),
          width: 1.sw,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "নাম পরিবর্তন করুন",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: size.textLarge,
                        color: clr.appPrimaryColorBlue),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      CupertinoIcons.clear_fill,
                      color: clr.iconColorRed,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.h10),
              AppStreamBuilder<UserDataEntity>(
                stream: profileDataStreamController.stream,
                loadingBuilder: (context) {
                  return Center(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 24.w,
                        right: 24.w,
                        top: 24.w,
                        bottom: 24.w,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18.w),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 42.w,
                            width: 42.w,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                clr.appPrimaryColorBlue,
                              ),
                              strokeWidth: 2.w,
                            ),
                          ),
                          SizedBox(
                            height: 16.w,
                          ),
                          Text(
                            "Please wait..",
                            style: TextStyle(
                              color: clr.appPrimaryColorBlue,
                              fontSize: 20.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                dataBuilder: (context, data) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "নামের প্রথম অংশ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: clr.textGrey,
                            fontSize: size.textSmall),
                      ),
                      SizedBox(
                        height: size.h8,
                      ),
                      TextField(
                        controller: firstName,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 1,
                        style: TextStyle(
                            color: clr.textColorBlack,
                            fontSize: size.textSmall,
                            fontWeight: FontWeight.w400,
                            fontFamily: StringData.fontFamilyOpenSans),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          hintText: "নামের প্রথম অংশ...",
                          hintStyle: TextStyle(
                              color: clr.placeHolderTextColorGray,
                              fontSize: size.textSmall,
                              fontWeight: FontWeight.w400,
                              fontFamily: StringData.fontFamilyPoppins),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: clr.greyColor, width: size.w1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(size.w8)),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: clr.boxStrokeColor, width: size.w1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(size.w8))),
                        ),
                      ),
                      SizedBox(
                        height: size.h20,
                      ),
                      Text(
                        "নামের শেষ অংশ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: clr.textGrey,
                            fontSize: size.textSmall),
                      ),
                      SizedBox(
                        height: size.h8,
                      ),
                      TextField(
                        controller: lastName,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 1,
                        style: TextStyle(
                            color: clr.textColorBlack,
                            fontSize: size.textSmall,
                            fontWeight: FontWeight.w400,
                            fontFamily: StringData.fontFamilyOpenSans),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          hintText: "নামের শেষ অংশ...",
                          hintStyle: TextStyle(
                              color: clr.placeHolderTextColorGray,
                              fontSize: size.textSmall,
                              fontWeight: FontWeight.w400,
                              fontFamily: StringData.fontFamilyPoppins),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: clr.greyColor, width: size.w1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(size.w8)),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: clr.boxStrokeColor, width: size.w1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(size.w8))),
                        ),
                      ),
                      SizedBox(
                        height: size.h24,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                CustomToasty.of(widget.context2).lockUI();

                                changeName();
                                CustomToasty.of(context).releaseUI();

                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.w10, vertical: size.h10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: clr.appPrimaryColorBlue,
                                ),
                                child: Center(
                                  child: Text(
                                    " আপডেট করুন ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: clr.whiteColor,
                                        fontSize: size.textXXSmall),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.w6,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.w10, vertical: size.h10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: clr.iconColorRed,
                                ),
                                child: Center(
                                  child: Text(
                                    " বাতিল করুন ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: clr.whiteColor,
                                        fontSize: size.textXXSmall),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  );
                },
                emptyBuilder: (context, message, icon) => Padding(
                    padding: EdgeInsets.all(size.h24),
                    child: Center(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Lottie.asset(ImageAssets.animEmpty,
                            height: size.h64 * 3),
                        SizedBox(height: size.h8),
                        Text(
                          message,
                          style: TextStyle(
                            color: clr.blackColor,
                            fontSize: size.textSmall,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ]),
                    )),
              ),
              SizedBox(height: size.h10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }

  @override
  void showSuccess(String message) {
    CustomToasty.of(context).showSuccess(message);
  }
}
