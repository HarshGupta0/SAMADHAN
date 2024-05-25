import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'MyrequestScreen.dart';
import 'ProfileScreen.dart';
import 'RequestPageList.dart';
import 'alllRequestsPage.dart';
class NavScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return PersistentTabView(
      context,
      controller: PersistentTabController(initialIndex: 0),
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Color(0xFFB3B1D3),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration:const NavBarDecoration(
          colorBehindNavBar: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10)
          )
      ),
      popAllScreensOnTapOfSelectedTab: true,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1,
    );
  }

  List<Widget> _buildScreens() {
    return [
      RequestListPage(),
      MyrequestScreen(),
      SettingsView(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: 'Home',
        activeColorPrimary:Colors.purple.shade400.withOpacity(.4),
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.category_outlined),
        title: 'Category',
        activeColorPrimary:Colors.purple.shade400.withOpacity(.4),
        inactiveColorPrimary: Colors.white,
      ),
      // PersistentBottomNavBarItem(
      //   icon: Icon(Icons.person_outline),
      //   title: 'Doctor',
      //   activeColorPrimary: Colors.blue,
      //   inactiveColorPrimary: Colors.white,
      // ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings_outlined),
        title: 'Profile',
        activeColorPrimary:Colors.purple.shade400.withOpacity(.4),
        inactiveColorPrimary: Colors.white,
      ),
    ];
  }
}