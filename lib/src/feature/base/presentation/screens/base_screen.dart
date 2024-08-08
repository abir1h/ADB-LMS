import 'package:adb_mobile/src/feature/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:adb_mobile/src/feature/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_theme.dart';
import '../../../../core/service/notifier/app_events_notifier.dart';
import '../services/base_screen_services.dart';
import '../../../../core/common_widgets/drawer_widget.dart';
import '../../../../core/constants/language.dart';
import '../../../../core/utility/app_label.dart';

class BaseScreen extends StatefulWidget {
  final Object? arguments;
  const BaseScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen>
    with AppTheme, BaseScreenService, AppEventsNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: clr.scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        drawer: const DrawerWidget(),
        body: Stack(
          fit: StackFit.expand,
          children: [
            ///Page body
            PageView.builder(
              controller: pageController,
              itemCount: 4,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return DashboardScreen(
                    key: ObjectKey(DateTime.now()),
                  );
                } else if (index == 1) {
                  return Container(
                    key: ObjectKey(DateTime.now()),
                  );
                } else if (index == 2) {
                  return ProfileScreen(
                    key: ObjectKey(DateTime.now()),
                  );
                }
                return const Center(child: Text("Unauthorized to access!"));
              },
            ),

            ///Bottom navigation bar
            BottomNavigationBar(
              onSelect: onTabSelected,
            ),
          ],
        ));
  }

  @override
  void navigateBookMarkScreen() {
    // TODO: implement navigateBookMarkScreen
  }

  @override
  void navigateToCategoryScreen() {
    // TODO: implement navigateToCategoryScreen
  }

  @override
  void navigateToHomeScreen() {
    // TODO: implement navigateToHomeScreen
  }

  @override
  void navigateToProfileScreen() {
    // TODO: implement navigateToProfileScreen
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

class BottomNavigationBar extends StatefulWidget {
  final void Function(int newIndex, int oldIndex) onSelect;
  const BottomNavigationBar({
    Key? key,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBar>
    with AppTheme, Language {
  int _selectedIndex = 0;

  _selectTab(int index) {
    int temp = _selectedIndex;
    if (mounted && _selectedIndex != index) {
      ///Animate navbar
      setState(() {
        _selectedIndex = index;
      });
      widget.onSelect(index, temp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.maxFinite,
        height: size.h64 + MediaQuery.of(context).padding.bottom,
        padding: EdgeInsets.only(
          left: size.w12,
          right: size.w12,
          top: size.h4,
          bottom: size.h4 + MediaQuery.of(context).padding.bottom,
        ),
        decoration: BoxDecoration(
          color: clr.whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(size.h24),
            topRight: Radius.circular(size.h24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              blurRadius: size.h8,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            NavButtonItem(
              title: "Dashboard",
              icon: _selectedIndex == 0 ? Icons.home_outlined : Icons.home,
              size: size.h32,
              selected: _selectedIndex == 0,
              onSelect: () => _selectTab(0),
            ),
            NavButtonItem(
              title: "Trainings",
              icon: _selectedIndex == 1
                  ? CupertinoIcons.book
                  : CupertinoIcons.book_fill,
              size: size.h32,
              selected: _selectedIndex == 1,
              onSelect: () => _selectTab(1),
            ),
            NavButtonItem(
              title: "Profile",
              icon: _selectedIndex == 2
                  ? Icons.person_2_outlined
                  : Icons.person,
              size: size.h32,
              selected: _selectedIndex == 2,
              onSelect: () => _selectTab(2),
            ),

          ],
        ),
      ),
    );
  }
}

class NavButtonItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final bool selected;
  final double size;
  final VoidCallback onSelect;

  const NavButtonItem(
      {Key? key,
      required this.icon,
      required this.title,
      required this.selected,
      required this.size,
      required this.onSelect})
      : super(key: key);

  @override
  State<NavButtonItem> createState() => _NavButtonItemState();
}

class _NavButtonItemState extends State<NavButtonItem> with AppTheme {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSelect,
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedScale(
              duration: const Duration(milliseconds: 200),
              alignment: Alignment.bottomCenter,
              scale: widget.selected ? 0.8 : 1.0,
              child: Icon(
                widget.icon,
                color: clr.appPrimaryColorBlue,
                size: widget.size,
              ),
            ),
            SizedBox(height: size.h2),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: widget.selected ? size.h20 : size.h8,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 200),
                alignment: Alignment.bottomCenter,
                scale: widget.selected ? 1.0 : 0.0,
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: clr.blackColor,
                    fontSize: size.textXXSmall,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import '../../../../core/common_widgets/custom_app_bar.dart';
// import '../../../../core/common_widgets/drawer_widget.dart';
// import '../../../../core/constants/language.dart';
// import '../../../../core/routes/app_routes.dart';
// import '../../../../core/service/notifier/app_events_notifier.dart';
//
// import '../../../../core/utility/app_label.dart';
//
// import '../../../../core/constants/common_imports.dart';
//
// class BaseScreen extends StatefulWidget {
//   const BaseScreen({
//     super.key,
//   });
//
//   @override
//   State<BaseScreen> createState() => _BaseScreenState();
// }
//
// class _BaseScreenState extends State<BaseScreen>
//     with AppTheme, Language, AppEventsNotifier {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final PageController _pageController = PageController();
//   int _currentPageIndex = 0;
//
//   List<Widget> pages = [
//     Container(),
//     Container(),
//     Container(),
//     Container(),
//   ];
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: _currentPageIndex == 3
//           ? clr.iconColorWhiteIce
//           : clr.scaffoldBackgroundColor,
//       drawer: const DrawerWidget(),
//
//       endDrawerEnableOpenDragGesture: false,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(size.h56),
//         child: CustomAppBar(
//           title: _currentPageIndex == 0
//               ? label(e: en.appBarText, b: bn.appBarText)
//               : _currentPageIndex == 1
//                   ? label(e: en.courseText, b: bn.courseText)
//                   : _currentPageIndex == 2
//                       ? label(e: en.allNotes, b: bn.allNotes)
//                       : label(e: en.profileAppBarText, b: bn.profileAppBarText),
//           leadingOnPressed: () {
//             //_scaffoldKey.currentState!.openDrawer();
//           },
//           hasDivider: true,
//           hasMenu: true,
//           automaticallyImplyLeading: false,
//           primaryColor: Colors.white,
//           toolbarHeight: size.h56,
//           trailingOnPressed: () {
//             if (_currentPageIndex != 2) {
//
//             }
//           },
//           trailing: _currentPageIndex == 2
//               ? Icon(
//                   Icons.search,
//                   color: clr.appPrimaryColorGreen,
//                   size: size.r24,
//                 )
//               : Stack(
//                   children: [
//                     Icon(
//                       Icons.notifications,
//                       color: clr.appPrimaryColorGreen,
//                       size: size.r24,
//                     ),
//                     Positioned(
//                       right: -1,
//                       top: 2.w,
//                       child: Container(
//                         width: size.w12,
//                         height: size.h12,
//                         decoration: BoxDecoration(
//                             color: clr.appPrimaryColorGreen,
//                             shape: BoxShape.circle,
//                             border: Border.all(color: clr.whiteColor)),
//                       ),
//                     ),
//                   ],
//                 ),
//           leading: Icon(
//             Icons.menu,
//             color: clr.appPrimaryColorGreen,
//             size: size.r24,
//           ),
//         ),
//       ),
//       body: pages[_currentPageIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.white,
//         currentIndex: _currentPageIndex,
//         selectedItemColor: clr.appSecondaryColorFlagRed,
//         unselectedItemColor: clr.appPrimaryColorGreen,
//         iconSize: 24.h,
//         selectedLabelStyle: TextStyle(
//             color: clr.appPrimaryColorGreen,
//             fontFamily: StringData.fontFamilyRoboto,
//             fontWeight: FontWeight.w400,
//             fontSize: 12.sp),
//         type: BottomNavigationBarType.fixed,
//         onTap: (index) {
//           setState(() {
//             _currentPageIndex = index;
//           });
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.home_outlined,
//               size: size.r24,
//             ),
//             label: label(e: en.homeText, b: bn.homeText),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.auto_stories,
//               size: size.r24,
//             ),
//             label: label(e: en.coursesText, b: bn.coursesText),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.assignment,
//               size: size.r24,
//             ),
//             label: label(e: en.notesText, b: bn.notesText),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               CupertinoIcons.profile_circled,
//               size: size.r24,
//             ),
//             label: label(e: en.profileText, b: bn.profileText),
//           ),
//         ],
//       ),
//
//     );
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   void onEventReceived(EventAction action) {
//     if (action == EventAction.bottomNavBar) {
//       if (mounted) {
//         setState(() {});
//       }
//     }
//   }
// }
