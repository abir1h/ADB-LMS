import 'package:adb_mobile/src/core/routes/app_route_args.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../config/local_storage_services.dart';
import '../routes/app_route.dart';
import '../service/auth_cache_manager.dart';
import '../service/notifier/app_events_notifier.dart';
import 'custom_dialog_widget.dart';
import '../constants/common_imports.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget>
    with AppTheme, Language, AppEventsNotifier {
  // final AccessibilityController accessibilityController =
  //     Get.put(AccessibilityController());
  String? userName, email;
  getUserInfo() async {
    LocalStorageService localStorageService =
        await LocalStorageService.getInstance();
    setState(() {
      userName = localStorageService.getStringValue(StringData.userName);
      email = localStorageService.getStringValue(StringData.email);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: clr.shadeWhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(size.w8)),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: size.w16, top: size.h32, right: size.w16),
                child: Image.asset(ImageAssets.icLogo),
              ),
              SizedBox(height: size.h24),
              DrawerLinkWidget(
                text: "ড্যাশবোর্ড",
                onTap: () {},
                icon: Icons.home_outlined,
                iconColor: clr.blackColor,
              ),
              DrawerLinkWidget(
                text: "প্রোফাইল",
                onTap: () => Navigator.pushNamed(context, AppRoute.baseScreen,
                    arguments: BaseScreenArgs(index: 2)),
                icon: Icons.person_2_outlined,
                iconColor: clr.blackColor,
              ),
              DrawerLinkWidget(
                text: "ব্যবহারকারীর নির্দেশনাবলী",
                onTap: () => Navigator.pushNamed(context, AppRoute.userMannual),
                icon: CupertinoIcons.book,
                iconColor: clr.blackColor,
              ),
              DrawerLinkWidget(
                text: "প্রজেক্ট সম্পর্কে",
                onTap: () =>
                    Navigator.pushNamed(context, AppRoute.projectDetails),
                icon: CupertinoIcons.book,
                iconColor: clr.blackColor,
              ),
              DrawerLinkWidget(
                text: "নোটিফিকেশন ",
                onTap: () =>
                    Navigator.pushNamed(context, AppRoute.notificationScreen),
                icon: CupertinoIcons.bell,
                iconColor: clr.blackColor,
              ),
              DrawerLinkWidget(
                text: "আমার প্রশিক্ষণ",
                onTap: () => Navigator.pushNamed(context, AppRoute.baseScreen,
                    arguments: BaseScreenArgs(index: 1)),
                icon: CupertinoIcons.book,
                iconColor: clr.blackColor,
              ),
              DrawerLinkWidget(
                  text: "সার্টিফিকেশন ",
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoute.certificateList),
                  faIcon: FaIcon(
                    FontAwesomeIcons.award,
                    size: size.r24,
                  )),
              DrawerLinkWidget(
                  text: "পাসওয়ার্ড পরিবর্তন করুন  ",
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoute.changePassword),
                  faIcon: FaIcon(
                    FontAwesomeIcons.key,
                    size: size.r24,
                  )),
              DrawerLinkWidget(
                text: " প্রস্থান ",
                onTap: () async {
                  showLogoutPromptDialog();
                },
                icon: Icons.logout,
                iconColor: clr.blackColor,
              ),
              SizedBox(height: size.h64)
            ],
          ),
        ),
      ),
    );
  }

  void showLogoutPromptDialog() {
    CustomDialogWidget.show(
      context: context,
      title: "আপনি কি নিশ্চিত?",
      infoText: "আপনি কি লগ আউট করতে চান?",
      leftButtonText: "বাতিল করুন",
      rightButtonText: "প্রস্থান করুন",
    ).then((value) {
      if (value) {
        AuthCacheManager.userLogout();
        Navigator.of(context)
            .pushNamedAndRemoveUntil(AppRoute.landingScreen, (x) => false);
      }
    });
  }
  // void showLogoutPromptDialog() {
  //   CustomDialogWidget.show(
  //     context: context,
  //     title: label(e: en.logoutWarningText, b: bn.logoutWarningText),
  //     infoText: label(
  //         e: "Your ID login is required for your courses and assessment news.",
  //         b: "আপনার কোর্সগুলো এবং মূল্যায়নের খবরের জন্য আপনার আইডি লগইন থাকা প্রয়োজন।"),
  //     leftButtonText: label(e: en.cancelText, b: bn.cancelText),
  //     rightButtonText: label(e: en.exitText, b: bn.exitText),
  //   ).then((value) {
  //     if (value) {
  //       AuthCacheManager.userLogout();
  //       Navigator.of(context).pushNamedAndRemoveUntil(
  //           AppRoute.authenticationScreen, (x) => false);
  //     }
  //   });
  // }

  @override
  void onEventReceived(EventAction action) {
    if (action == EventAction.drawer) {
      if (mounted) {
        setState(() {});
      }
    }
  }
}

class DrawerLinkWidget extends StatelessWidget with AppTheme {
  final Color cardColor;
  final IconData? icon;
  final Color? iconColor;
  final FaIcon? faIcon;
  final String text;
  final Widget? widget;
  final VoidCallback onTap;
  const DrawerLinkWidget({
    Key? key,
    this.cardColor = Colors.transparent,
    this.icon,
    this.iconColor,
    this.faIcon,
    required this.text,
    this.widget,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
        decoration: BoxDecoration(
          color: cardColor,
          border: Border(
              bottom: BorderSide(width: size.h1, color: clr.cardStrokeColor)),
        ),
        child: Row(
          children: [
            if (icon != null)
              Padding(
                padding: EdgeInsets.only(right: size.w10),
                child: Icon(
                  icon,
                  size: size.r24,
                  color: iconColor ?? clr.iconColorHint,
                ),
              ),
            if (faIcon != null)
              Padding(padding: EdgeInsets.only(right: size.w10), child: faIcon),
            Expanded(
              child: Text(text,
                  style: TextStyle(
                    color: clr.textColorAppleBlack,
                    fontSize: size.textSmall,
                    fontFamily: StringData.fontFamilyPoppins,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            if (widget != null) widget!
          ],
        ),
      ),
    );
  }
}
