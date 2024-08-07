import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../feature/accessibility/presentation/controllers/accessibility_controller.dart';
import '../../feature/accessibility/presentation/screens/accessibility_bottom_sheet.dart';
import '../routes/app_route.dart';
import '../service/auth_cache_manager.dart';
import '../service/notifier/app_events_notifier.dart';
import 'custom_dialog_widget.dart';
import 'custom_switch_button.dart';
import '../utility/app_label.dart';
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
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: clr.cardStrokeColor, width: size.w1)),
                      child: CircleAvatar(
                        radius: 24.r,
                        backgroundColor: clr.appPrimaryColorGreen,
                        child: Center(
                          child: Text(
                            localStorage
                                .getStringValue(StringData.userName)![0]
                                .toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: size.textXLarge),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: size.w12),
                    Expanded(
                      child: Text(
                        localStorage.getStringValue(StringData.userName)!,
                        style: TextStyle(
                            color: clr.appPrimaryColorGreen,
                            fontSize: size.textMedium,
                            fontWeight: FontWeight.w500,
                            fontFamily: StringData.fontFamilyPoppins),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.h24),
              Padding(
                padding: EdgeInsets.only(left: size.w16),
                child: CustomSwitchButton(
                  value: App.currentAppLanguage == AppLanguage.english,
                  textOn: 'EN',
                  textSize: size.textXXSmall,
                  textOff: 'বাং',
                  bgColor: clr.whiteColor,
                  width: 64.w,
                  animationDuration: const Duration(milliseconds: 300),
                  onChanged: (bool state) {
                    App.setAppLanguage(state ? 1 : 0).then((value) {
                      if (mounted) {
                        setState(() {});
                      }
                      AppEventsNotifier.notify(EventAction.bottomNavAllScreen);
                      AppEventsNotifier.notify(EventAction.bottomNavBar);
                      AppEventsNotifier.notify(EventAction.graphChart);
                    });
                  },
                  buttonHolder: const Icon(
                    Icons.check,
                    color: Colors.transparent,
                  ),
                  onTap: () {},
                  onDoubleTap: () {},
                  onSwipe: () {},
                ),
              ),
              SizedBox(height: size.h12),
              Container(height: size.h1, color: clr.cardStrokeColor),
              DrawerLinkWidget(
                cardColor: clr.drawerFillColor,
                icon: Icons.auto_stories,
                iconColor: clr.appPrimaryColorGreen,
                text: label(e: en.lms, b: bn.lms),
                onTap: () {},
              ),
              DrawerLinkWidget(
                icon: Icons.local_library,
                text: label(e: en.teachersGuide, b: bn.teachersGuide),
                onTap: () {},
              ),
              DrawerLinkWidget(
                svgIcon: ImageAssets.icBook,
                text: label(e: en.eLibrary, b: bn.eLibrary),
                onTap: () {},
              ),
              DrawerLinkWidget(
                svgIcon: ImageAssets.icSocialLearning,
                text: label(
                    e: en.socialLearningPlatform, b: bn.socialLearningPlatform),
                onTap: () {},
              ),
              DrawerLinkWidget(
                icon: Icons.forum,
                text: label(e: en.discussionArea, b: bn.discussionArea),
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoute.discussionScreen),
              ),
              DrawerLinkWidget(
                icon: Icons.play_circle,
                text: label(e: en.tutorial, b: bn.tutorial),
                onTap: () {},
              ),
              DrawerLinkWidget(
                icon: Icons.chat_bubble,
                text: label(e: en.messageText, b: bn.messageText),
                onTap: () {},
              ),
              DrawerLinkWidget(
                svgIcon: ImageAssets.icCircular,
                text: label(e: en.circular, b: bn.circular),
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoute.circularScreen),
              ),
              /*DrawerLinkWidget(
                icon: Icons.accessible,
                text: label(e: en.accessibilityText, b: bn.accessibilityText),
                onTap: () {},
                widget: Obx(
                  () => SizedBox(
                      width: 40.sp,
                      height: 40.sp,
                      child: FittedBox(
                        child: CupertinoSwitch(
                          applyTheme: true,
                          value: accessibilityController.isGrayscale.value,
                          onChanged: (v) {
                            accessibilityController.toggleGrayscale();
                          },
                          activeColor: clr.appPrimaryColorGreen,
                        ),
                      )),
                ),
              ),*/
              DrawerLinkWidget(
                icon: Icons.accessible,
                text: label(e: en.accessibilityText, b: bn.accessibilityText),
                onTap: () => onTapAccessibility(),
              ),
              DrawerLinkWidget(
                icon: Icons.contact_support,
                text: label(e: en.aboutUs, b: bn.aboutUs),
                onTap: () {},
              ),
              DrawerLinkWidget(
                icon: Icons.logout,
                iconColor: clr.textColorBlack,
                text: label(e: en.logoutText, b: bn.logoutText),
                onTap: showLogoutPromptDialog,
              ),
              SizedBox(height: size.h64)
            ],
          ),
        ),
      ),
    );
  }

  void onTapAccessibility() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => const AccessibilityBottomSheet(),
    ).then((value) => setState(() {}));
  }

  void showLogoutPromptDialog() {
    CustomDialogWidget.show(
      context: context,
      title: label(e: en.logoutWarningText, b: bn.logoutWarningText),
      infoText: label(
          e: "Your ID login is required for your courses and assessment news.",
          b: "আপনার কোর্সগুলো এবং মূল্যায়নের খবরের জন্য আপনার আইডি লগইন থাকা প্রয়োজন।"),
      leftButtonText: label(e: en.cancelText, b: bn.cancelText),
      rightButtonText: label(e: en.exitText, b: bn.exitText),
    ).then((value) {
      if (value) {
        AuthCacheManager.userLogout();
        Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoute.authenticationScreen, (x) => false);
      }
    });
  }

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
  final String? svgIcon;
  final String text;
  final Widget? widget;
  final VoidCallback onTap;
  const DrawerLinkWidget({
    Key? key,
    this.cardColor = Colors.transparent,
    this.icon,
    this.iconColor,
    this.svgIcon,
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
            if (svgIcon != null)
              Padding(
                padding: EdgeInsets.only(right: size.w10),
                child: SvgPicture.asset(
                  svgIcon!,
                  height: size.h24,
                  colorFilter: ColorFilter.mode(
                      iconColor ?? clr.iconColorHint, BlendMode.srcIn),
                  // color: clr.hintIconColor,
                ),
              ),
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
