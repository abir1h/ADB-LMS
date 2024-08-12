import 'package:adb_mobile/src/core/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'dashboard_ card_loader.dart';
class LoaderDashbaord extends StatelessWidget with AppTheme {
  const LoaderDashbaord({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: size.h20,),
        Row(
          children: [
            Expanded(
                child: DashboardCardLoader(
                  primary: true,
                  title: 'নিবন্ধিত প্রশিক্ষণ',
                  subTitle:"",
                  bgColor: clr.cardColor1,
                  borderColor: clr.cardColorBorder1,
                  faIcon: FaIcon(
                    FontAwesomeIcons.book,
                    size: size.h40,
                  ),
                )),
          ],
        ),
        SizedBox(
          height: size.h32,
        ),
        Row(
          children: [
            Expanded(
                child: DashboardCardLoader(
                  title: 'সার্টিফিকেট',
                  subTitle:" ",
                  bgColor: clr.cardColor2,
                  borderColor: clr.cardColorBorder2,
                  faIcon: FaIcon(
                    FontAwesomeIcons.graduationCap,
                    size: size.h40,
                  ),
                )),
            SizedBox(
              width: size.w20,
            ),
            Expanded(
                child: DashboardCardLoader(
                  title: 'আমার মূল্যায়ন',
                  subTitle: "",
                  bgColor: clr.cardColor3,
                  borderColor: clr.cardColorBorder3,
                  faIcon: FaIcon(
                    FontAwesomeIcons.award,
                    size: size.h40,
                  ),
                )),
          ],
        ),


        SizedBox(
          height: size.h20,
        ),
      ],
    );
  }
}
