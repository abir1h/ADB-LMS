import 'dart:io';

import 'package:adb_mobile/src/core/common_widgets/app_dropdown_widget.dart';
import 'package:adb_mobile/src/feature/profile/domain/entities/user_data_entity.dart';
import 'package:adb_mobile/src/feature/profile/presentation/widgets/profile_shimmer_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/drawer_widget.dart';
import '../../../../core/common_widgets/empty_widget.dart';
import '../../../../core/common_widgets/shimmer_loader.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/constants/language.dart';
import '../service/profile_screen_service.dart';
import 'package:badges/badges.dart' as badges;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AppTheme, Language, ProfileScreenService {
  @override
  void initState() {
    super.initState();
  }

  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clr.scaffoldBackgroundColor,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(
            Icons.menu,
            color: clr.appPrimaryColorBlue,
          ),
        ),
        automaticallyImplyLeading: false,
        leadingWidth: size.w40,
        title: Text(
          "প্রোফাইল",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: size.textSmall,
              color: clr.appPrimaryColorBlue),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.notifications_sharp,
              color: clr.appPrimaryColorBlue,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
        physics: const BouncingScrollPhysics(),
        child: AppStreamBuilder<UserDataEntity>(
          stream: categoryDataStreamController.stream,
          loadingBuilder: (context) {
            return const ProfileShimmerLoader();
          },
          dataBuilder: (context, data) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.h24,
                ),
                Center(
                  child: badges.Badge(
                    badgeStyle:  badges.BadgeStyle(
                      elevation: 1,
                      badgeColor: clr.appPrimaryColorBlue,
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                    badgeContent: GestureDetector(
                        onTap: () {
                          showImagePickerBottomSheet(context);
                        },
                        child: Icon(Icons.edit,
                            color: Colors.white, size: size.r24)),
                    position:
                        badges.BadgePosition.bottomEnd(bottom: 10, end: 2),
                    child: CircleAvatar(
                      radius: 68.r,
                      backgroundColor: Colors.grey.withOpacity(.2),
                      child: CircleAvatar(
                        radius: 66.r,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                            radius: 64.r,
                            backgroundImage: NetworkImage(
                                ApiCredential.mediaBaseUrl + data.imagePath)),
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
                    Text(
                      'ইউজারের নাম	',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: clr.greyColor,
                          fontSize: size.textSmall),
                    ),
                    SizedBox(
                      height: size.h16,
                    ),
                    Text(
                      data.userName,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: clr.blackColor,
                          fontSize: size.textSmall),
                    ),
                    SizedBox(
                      height: size.h16,
                    ),
                    Text(
                      'নাম	',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: clr.greyColor,
                          fontSize: size.textSmall),
                    ),
                    SizedBox(
                      height: size.h16,
                    ),
                    Text(
                      data.fullName,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: clr.blackColor,
                          fontSize: size.textSmall),
                    ),
                    SizedBox(
                      height: size.h16,
                    ),
                    Text(
                      'লিঙ্গ		',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: clr.greyColor,
                          fontSize: size.textSmall),
                    ),
                    SizedBox(
                      height: size.h16,
                    ),
                    Text(
                      data.gender,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: clr.blackColor,
                          fontSize: size.textSmall),
                    ),
                    SizedBox(
                      height: size.h16,
                    ),
                    Text(
                      'ইমেইল		',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: clr.greyColor,
                          fontSize: size.textSmall),
                    ),
                    SizedBox(
                      height: size.h16,
                    ),
                    Text(
                      data.email,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: clr.blackColor,
                          fontSize: size.textSmall),
                    ),
                    SizedBox(
                      height: size.h16,
                    ),
                    Text(
                      'ফোন		',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: clr.greyColor,
                          fontSize: size.textSmall),
                    ),
                    SizedBox(
                      height: size.h16,
                    ),
                    Text(
                      data.phoneNumber,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: clr.blackColor,
                          fontSize: size.textSmall),
                    ),
                    SizedBox(
                      height: size.h16,
                    ),
                    Text(
                      'ঠিকানা		',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: clr.greyColor,
                          fontSize: size.textSmall),
                    ),
                    SizedBox(
                      height: size.h16,
                    ),
                    Text(
                      data.address,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: clr.blackColor,
                          fontSize: size.textSmall),
                    ),
                    SizedBox(
                      height: size.h16,
                    ),
                  ],
                ),
                SizedBox(
                  height: size.h64 + size.h32,
                ),
              ],
            );
          },
          emptyBuilder: (context, message, icon) => Padding(
              padding: EdgeInsets.all(size.h24),
              child: Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Lottie.asset(ImageAssets.animEmpty, height: size.h64 * 3),
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
      ),
    );
  }

  @override
  void navigateToLoginScreen() {
    Navigator.of(context).pushNamed(
      AppRoute.loginScreen,
    );
  }

  @override
  void navigateToSignUpScreen() {
    Navigator.of(context).pushNamed(
      AppRoute.regScreen,
    );
  }

  @override
  void showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }

  Future<File?> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  void showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext c) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.image),
                title: Text('Choose from gallery'),
                onTap: () async {
                  Navigator.of(c).pop();
                  final pickedImage = await pickImage(ImageSource.gallery);
                  if (pickedImage != null && mounted) {
                    print(pickedImage.path);
                    uploadProfile(pickedImage, context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
