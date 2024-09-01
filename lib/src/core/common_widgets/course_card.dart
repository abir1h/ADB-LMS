import 'package:adb_mobile/src/feature/dashboard/domain/entities/course_info_data_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/common_imports.dart'; // Adjust the import paths based on your project structure

class CourseCard extends StatelessWidget with AppTheme {
  final CourseInfoDataEntity data;
  final VoidCallback onTap;

  const CourseCard({super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(8.r),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(8.r),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            ApiCredential.mediaBaseUrl+data.imagePath,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                        fit: BoxFit.contain,
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
                      child: Text(
                        "নিবন্ধিত ",
                        style: TextStyle(
                          color: Colors.yellow,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              data.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: clr.appPrimaryColorBlue,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                fontFamily: StringData
                    .fontFamilyOpenSans, // Ensure the font is properly imported
              ),
            ),
            SizedBox(
              height: size.h20,
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(size.w10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size.r10),
                    color: clr.ratingBgColor,
                  ),
                  child: Row(
                    children: [
                      Text(
                        data.rating.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: clr.blackColor,
                            fontSize: size.textSmall),
                      ),
                      SizedBox(
                        width: size.w12,
                      ),
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      )
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
                Container(
                  padding: EdgeInsets.all(size.w10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size.r10),
                    color: clr.enterTrainingButtonColor,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "প্রশিক্ষণে প্রবেশ করুন",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: clr.whiteColor,
                            fontSize: size.textSmall),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
