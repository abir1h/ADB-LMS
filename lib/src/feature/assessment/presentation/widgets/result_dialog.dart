import 'package:adb_mobile/src/core/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultDialog extends StatefulWidget {
  const ResultDialog({super.key});

  @override
  State<ResultDialog> createState() => _ResultDialogState();
}

class _ResultDialogState extends State<ResultDialog> with AppTheme {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                     IconButton(onPressed: (){Navigator.pop(context); }, icon:  Icon(
                       Icons.clear,
                       color: clr.blackColor,
                       size: size.r24,
                     ),)
                    ],
                  ),

                  Center(
                      child: Text(
                    "পরীক্ষার ফলাফল",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: size.textLarge,
                        color: clr.appPrimaryColorBlue),
                  )),
                  SizedBox(
                    height: size.h12,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(size.r10),
                            color: clr.cardColor2),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "সঠিক উত্তর ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: size.textXXSmall,
                                    color: clr.whiteColor),
                              ),
                              Text(
                                " 0 out of 5",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: size.textSmall,
                                    color: clr.whiteColor),
                              ),
                            ],
                          ),
                        ),
                      )),
                      SizedBox(
                        width: size.w20,
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(size.r10),
                            color: clr.cardColor1),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "শতকরা নম্বর ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: size.textXXSmall,
                                    color: clr.whiteColor),
                              ),
                              Text(
                                " 0%",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: size.textSmall,
                                    color: clr.whiteColor),
                              ),
                            ],
                          ),
                        ),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: size.h20,
                  ),
                  SizedBox(
                    height: size.h12,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "⚫️ ",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: size.textSmall,
                            color: clr.blackColor),
                      ),
                      Expanded(
                          child: Text(
                        "শতকরা ৫০% নম্বর না পেলে আপনি সার্টিফিকেট পাবেন না। অনুগ্রহপূর্বক আবার চেষ্টা করুন।",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: size.textSmall,
                            color: clr.blackColor),
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
