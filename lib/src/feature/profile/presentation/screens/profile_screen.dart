import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/user_data_entity.dart';
import '../widgets/profile_shimmer_loader.dart';
import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/drawer_widget.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route.dart';
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
              child: IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoute.notificationScreen),
                icon: Icon(
                  Icons.notifications_sharp,
                  color: clr.appPrimaryColorBlue,
                ),
              ))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
        physics: const BouncingScrollPhysics(),
        child: AppStreamBuilder<UserDataEntity>(
          stream: profileDataStreamController.stream,
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
                    badgeStyle: badges.BadgeStyle(
                      elevation: 1,
                      badgeColor: clr.appPrimaryColorBlue,
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2),
                    ),
                    badgeContent: GestureDetector(
                      onTap: () {
                        showImagePickerBottomSheet(context);
                      },
                      child:
                          Icon(Icons.edit, color: Colors.white, size: size.r24),
                    ),
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
                          child: CachedNetworkImage(
                              imageUrl:
                                  ApiCredential.mediaBaseUrl + data.imagePath,
                              fit: BoxFit.contain,
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                    radius: 64.r,
                                    backgroundImage: imageProvider,
                                  ),
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Image.asset(ImageAssets.emptyProfile)),
                        ),
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
                    /*   ProfileWidget(iconData: Icon(Icons.person,size: 30.r,),title: data.userName,),
                    SizedBox(height: size.h10,),
                    ProfileWidget(iconData: Icon(Icons.person,size: 30.r,),title: data.firstName+data.lastName,),*/
                    ProfileWidget(
                      title: 'ইউজারের নাম	',
                      subTitle: data.userName,
                    ),
                    SizedBox(
                      height: size.h16,
                    ),
                    ProfileWidget(
                      title: 'নাম	',
                      subTitle: data.fullName,
                    ),
                    SizedBox(
                      height: size.h16,
                    ),
                    ProfileWidget(
                      title: 'লিঙ্গ	',
                      subTitle: data.gender,
                    ),
                    SizedBox(
                      height: size.h16,
                    ),
                    ProfileWidget(
                      title: 'ইমেইল	',
                      subTitle: data.email.isEmpty ? "N/A" : data.email,
                    ),
                    SizedBox(
                      height: size.h16,
                    ),
                    ProfileWidget(
                      title: 'ফোন	',
                      subTitle: data.phoneNumber,
                    ),
                    SizedBox(
                      height: size.h16,
                    ),
                    ProfileWidget(
                      title: 'ঠিকানা	',
                      subTitle: data.address,
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Choose from gallery'),
                onTap: () async {
                  Navigator.of(c).pop();
                  final pickedImage = await pickImage(ImageSource.gallery);
                  if (pickedImage != null && mounted) {
                    if (kDebugMode) {
                      print(pickedImage.path);
                    }
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

class ProfileWidget extends StatelessWidget with AppTheme {
  final String title, subTitle;
  const ProfileWidget({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: clr.greyColor,
              fontSize: size.textSmall),
        ),
        SizedBox(
          height: size.h10,
        ),
        Text(
          subTitle,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: clr.blackColor,
              fontSize: size.textSmall),
        ),
      ],
    );
  }
}
