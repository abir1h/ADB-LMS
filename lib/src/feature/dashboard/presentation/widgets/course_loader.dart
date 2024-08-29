import 'package:adb_mobile/src/core/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/dashboard_screen.dart';
class CourseLoader extends StatelessWidget with AppTheme{
  const CourseLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return  CourseSectionWidget(
        items: const ["","",""],
        buildItem: (BuildContext context, int index, item) {
          return Container(
            padding: EdgeInsets.all(8.w), // Responsive padding
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8.r,
                  offset: Offset(0, 4.r),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 7,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.grey,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(8.r),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(8.r),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(8.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4.r,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),

                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Container(
                  width: .7.sw,
                  height: 20.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),color: Colors.grey
                  ),
                ),
                SizedBox(
                  height: size.h20,
                ),   Container(
                  width: .5.sw,
                  height: 20.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),color: Colors.grey
                  ),
                ),
              ],
            ),
          );
        });
  }
}
