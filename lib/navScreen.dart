import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'Core_features/RecievedResponds.dart';
import 'Core_features/userOwnRequests.dart';
import 'ProfileScreen.dart';
import 'Core_features/RequestPageList.dart';
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
      itemAnimationProperties:const ItemAnimationProperties(
        duration:const Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
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
      UserOwnRequests(),
      RecievedResponds(),
      SettingsView(),
      // RequestDetailsPage(request:null,),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: 'Home',
        activeColorPrimary:Colors.purple.shade400.withOpacity(.4),
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon:const Icon(Icons.person),
        title: 'My Request',
        activeColorPrimary:Colors.purple.shade400.withOpacity(.4),
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.message),
        title: 'message',
        activeColorPrimary:Colors.purple.shade400.withOpacity(.4),
        inactiveColorPrimary: Colors.white,
      ),

      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings_outlined),
        title: 'Profile',
        activeColorPrimary:Colors.purple.shade400.withOpacity(.4),
        inactiveColorPrimary: Colors.white,
      ),
    ];
  }
}
