import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_drive_hub/constant/palette.dart';
import 'package:mobile_drive_hub/helpers/dio.dart';
import 'package:mobile_drive_hub/services/token_services.dart';
import 'package:mobile_drive_hub/views/instructurs/calendar/calendar_screen.dart';
import 'package:mobile_drive_hub/views/schools/map_screens.dart';
import 'package:mobile_drive_hub/views/shared_screen/messages/conversation_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../profile_screen.dart';
import '../schedules_screen/instructor_schedules_screen.dart';

class InstructormMainScreen extends StatelessWidget {
  InstructormMainScreen({super.key});
  List<Widget> buildScreens() {
    return [
      const InstructorScheduleScreen(),
      const ConversationScreen(),
      const InstructorProfileScreen(),
    ];
  }

  final PersistentTabController controller =
      PersistentTabController(initialIndex: 0);
  int currentIndex = 0;
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.schedule_outlined),
        title: "Schedules",
        activeColorPrimary: primaryBg,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      // PersistentBottomNavBarItem(
      //   icon: const Icon(Icons.calendar_month_outlined),
      //   title: "Calendar",
      //   activeColorPrimary: primaryBg,
      //   inactiveColorPrimary: CupertinoColors.systemGrey,
      // ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.chat_bubble_outline_rounded),
        title: "Chats",
        activeColorPrimary: primaryBg,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person_2_outlined),
        title: "Profile",
        activeColorPrimary: primaryBg,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    print(currentIndex);
    return PersistentTabView(
      context,
      controller: controller,
      onItemSelected: (value) {
        currentIndex = value;
      },
      screens: buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
}
