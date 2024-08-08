import 'package:adb_mobile/src/core/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common_widgets/shimmer_loader.dart';
class ProfileShimmerLoader extends StatefulWidget {
  const ProfileShimmerLoader({super.key});

  @override
  State<ProfileShimmerLoader> createState() => _ProfileShimmerLoaderState();
}

class _ProfileShimmerLoaderState extends State<ProfileShimmerLoader> with AppTheme {
  @override
  Widget build(BuildContext context) {
    return ShimmerLoader(
      child:   Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.h24,
          ),

          Center(
            child: CircleAvatar(
              radius: 68.r,
              child: CircleAvatar(
                radius: 66.r,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 64.r,backgroundColor: Colors.grey,
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.h24,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 1.sw,
                height: 50.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),color: Colors.grey
                ),
              ),SizedBox(height: size.h24,), Container(
                width: 1.sw,
                height: 50.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),color: Colors.grey
                ),
              ),SizedBox(height: size.h24,), Container(
                width: 1.sw,
                height: 50.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),color: Colors.grey
                ),
              ),SizedBox(height: size.h24,), Container(
                width: 1.sw,
                height: 50.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),color: Colors.grey
                ),
              ),SizedBox(height: size.h24,), Container(
                width: 1.sw,
                height: 50.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),color: Colors.grey
                ),
              ),SizedBox(height: size.h24,),



            ],
          ),
          SizedBox(
            height: size.h64 + size.h32,
          ),
        ],
      ),);
  }
}
