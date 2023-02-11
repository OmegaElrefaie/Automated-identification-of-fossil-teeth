import 'package:graduation_project/view/user/screens/home.dart';
import 'package:graduation_project/view/user/screens/library.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final controller = PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreen() {
    return [
      const SafeArea(child: HomePage()),
      const SafeArea(child: Library()),
      const SafeArea(child: Text('Community')),
      const SafeArea(child: Text('Settings')),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.home,
          color: Colors.white,
        ),
        title: "Home",
        activeColorPrimary: kPrimaryColor,
        activeColorSecondary: Colors.white,
        inactiveIcon: const Icon(Icons.home, color: Colors.grey),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.photo,
          color: Colors.white,
        ),
        title: "Library",
        activeColorPrimary: kPrimaryColor,
        activeColorSecondary: Colors.white,
        inactiveIcon: const Icon(Icons.photo, color: Colors.grey),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.people_alt,
          color: Colors.white,
        ),
        title: "Community",
        activeColorPrimary: kPrimaryColor,
        activeColorSecondary: Colors.white,
        inactiveIcon: const Icon(Icons.people_alt, color: Colors.grey),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.settings,
          color: Colors.white,
        ),
        title: "Settings",
        activeColorPrimary: kPrimaryColor,
        activeColorSecondary: Colors.white,
        inactiveIcon: const Icon(Icons.settings, color: Colors.grey),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreen(),
      items: _navBarItem(),
      confineInSafeArea: true,
      resizeToAvoidBottomInset: true,
      hideNavigationBarWhenKeyboardShows: true,
      popAllScreensOnTapOfSelectedTab: true,
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 100),
      ),
      backgroundColor: Colors.white,
      decoration: const NavBarDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(29, 0, 0, 0),
                blurRadius: 9.0,
                spreadRadius: 0,
                offset: Offset(0, 0))
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      navBarStyle: NavBarStyle.style7,
    );
  }
}
