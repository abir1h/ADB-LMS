import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/common_widgets/drawer_widget.dart';
import '../../../course/presentation/screens/course_list_screen.dart';
import '../../../../core/routes/app_route_args.dart';
import '../../../../core/service/notifier/app_events_notifier.dart';
import '../../../../core/constants/common_imports.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../../dashboard/presentation/screens/dashboard_screen.dart';

class BaseScreen extends StatefulWidget {
  final Object? arguments;
  const BaseScreen({super.key, this.arguments});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen>
    with AppTheme, Language, AppEventsNotifier {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  List<Widget> pages = [
    const DashboardScreen(),
    const CourseListScreen(),
    const ProfileScreen(),
  ];
  BaseScreenArgs? _baseScreenArgs;
  @override
  void initState() {
    super.initState();
    _baseScreenArgs = widget.arguments as BaseScreenArgs;

    setPage();
  }

  setPage() {
    _currentPageIndex = _baseScreenArgs!.index;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      drawer: const DrawerWidget(),
      body: pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentPageIndex,
        selectedItemColor: clr.appPrimaryColorBlue,
        unselectedItemColor: clr.greyColor,
        iconSize: 24.h,
        selectedLabelStyle: TextStyle(
            color: clr.appPrimaryColorBlue,
            fontFamily: StringData.fontFamilyRoboto,
            fontWeight: FontWeight.w400,
            fontSize: 12.sp),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              _currentPageIndex == 0 ? Icons.home_outlined : Icons.home,
              size: size.r24,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentPageIndex == 1
                  ? Icons.auto_stories_outlined
                  : Icons.auto_stories,
              size: size.r24,
            ),
            label: "Trainings",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentPageIndex == 2
                  ? CupertinoIcons.person
                  : CupertinoIcons.person_fill,
              size: size.r24,
            ),
            label: "Profile",
          ),
         
        ],
      ),
     
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void onEventReceived(EventAction action) {
    if (action == EventAction.bottomNavBar) {
      if (mounted) {
        setState(() {});
      }
    }
  }


}
