import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/common_widgets/app_stream.dart';
import '../../../../core/common_widgets/course_card.dart';
import '../../../../core/common_widgets/custom_toasty.dart';
import '../../../../core/common_widgets/dashboard_card_widget.dart';
import '../../../../core/common_widgets/drawer_widget.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../../core/routes/app_route.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../domain/entities/course_info_data_entity.dart';
import '../../domain/entities/trainee_count_data_entity.dart';
import '../services/dashboard_screen_service.dart';
import '../widgets/course_loader.dart';
import '../widgets/loader_dashbaord.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with AppTheme, Language, DashboardScreenService {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            " ড্যাশবোর্ড ",
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
            padding:
                EdgeInsets.symmetric(horizontal: size.w16, vertical: size.h12),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                AppStreamBuilder<TraineeCountDataEntity>(
                  stream: traineeCountStreamController.stream,
                  loadingBuilder: (context) {
                    return LoaderDashbaord();
                  },
                  dataBuilder: (context, data) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.h24,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: DashboardCardWidget(
                              primary: true,
                              title: 'নিবন্ধিত প্রশিক্ষণ',
                              subTitle: data.enrollments.toString(),
                              bgColor: clr.cardColor1,
                              borderColor: clr.cardColorBorder1,
                              faIcon: FaIcon(
                                FontAwesomeIcons.book,
                                size: size.h40,
                              ),
                              onTap: () => Navigator.pushNamed(
                                  context, AppRoute.baseScreen,
                                  arguments: BaseScreenArgs(index: 1)),
                            )),
                          ],
                        ),
                        SizedBox(
                          height: size.h32,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: DashboardCardWidget(
                              title: 'সার্টিফিকেট',
                              subTitle: data.certificates.toString(),
                              bgColor: clr.cardColor2,
                              borderColor: clr.cardColorBorder2,
                              faIcon: FaIcon(
                                FontAwesomeIcons.graduationCap,
                                size: size.h40,
                              ),
                              onTap: ()=>Navigator.pushNamed(context,AppRoute.certificateList),
                            )),
                            SizedBox(
                              width: size.w20,
                            ),
                            Expanded(
                                child: DashboardCardWidget(
                              title: 'আমার মূল্যায়ন',
                              subTitle: data.examTaken.toString(),
                              bgColor: clr.cardColor3,
                              borderColor: clr.cardColorBorder3,
                              faIcon: FaIcon(
                                FontAwesomeIcons.award,
                                size: size.h40,
                              ),
                              onTap: () {},
                            )),
                          ],
                        ),
                        SizedBox(
                          height: size.h20,
                        ),
                      ],
                    );
                  },
                  emptyBuilder: (context, message, icon) => Padding(
                      padding: EdgeInsets.all(size.h24),
                      child: Center(
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
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
                AppStreamBuilder<List<CourseInfoDataEntity>>(
                  stream: courseStreamController.stream,
                  loadingBuilder: (context) {
                    return CourseLoader();
                  },
                  dataBuilder: (context, data) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "আমার প্রশিক্ষণ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: size.h24 + size.h2,
                              fontFamily: StringData.fontFamilyOpenSans,
                              color: clr.appPrimaryColorBlue),
                        ),
                        SizedBox(
                          height: size.h20,
                        ),
                        CourseSectionWidget(
                            items: data,
                            buildItem: (BuildContext context, int index, item) {
                              return CourseCard(
                                data: item,
                                onTap: () => Navigator.of(context).pushNamed(
                                    AppRoute.courseOverViewScreen,
                                    arguments:
                                        CourseDetailsScreenArgs(data: item)),
                              );
                            }),
                        SizedBox(
                          height: size.h64 + size.h32,
                        ),
                      ],
                    );
                  },
                  emptyBuilder: (context, message, icon) => Padding(
                      padding: EdgeInsets.all(size.h24),
                      child: Center(
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
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
              ],
            )),
      ),
    );
  }

  @override
  showWarning(String message) {
    CustomToasty.of(context).showWarning(message);
  }

  @override
  void navigateToLandingScreen() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AppRoute.landingScreen, (x) => false);
  }
}

class CourseSectionWidget<T> extends StatelessWidget with AppTheme {
  final List<T> items;
  final Widget Function(BuildContext context, int index, T item) buildItem;

  const CourseSectionWidget(
      {Key? key, required this.items, required this.buildItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return buildItem(context, index, items[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: size.h20);
      },
    );
  }
}
