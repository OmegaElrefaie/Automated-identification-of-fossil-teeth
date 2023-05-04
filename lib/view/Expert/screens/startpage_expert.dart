import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_project/view/expert/screens/home_expert.dart';
import 'package:graduation_project/view/user/screens/home.dart';
import 'package:graduation_project/view/user/screens/library.dart';
import 'package:graduation_project/view/user/screens/setting.dart';
import 'package:graduation_project/view/user/widgets/drawer.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../widget/drawerwidget.dart';
import 'chat_expert.dart';

class StartPageExpert extends StatefulWidget {
  const StartPageExpert({super.key});

  @override
  State<StartPageExpert> createState() => _StartPageExpertState();
}

class _StartPageExpertState extends State<StartPageExpert> {
  final controller = PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreen() {
    return [
      const SafeArea(child: HomePageExpert()),
      const SafeArea(child: Library()),
      SafeArea(child: Headerr()),
    ];
  }

  @override
  void initState() {
    super.initState();
    saveMessagingToken();
  }

// Function to get the messaging token and save it to the user's document
  Future<void> saveMessagingToken() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    // Get the messaging token for the user
    final FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? messagingToken = await messaging.getToken();

    if (messagingToken != null && userId != null) {
      try {
        // Get a reference to the user's document in Firestore
        final userRef =
            FirebaseFirestore.instance.collection('Users').doc(userId);

        // Update the user's document with the new messaging token
        await userRef.update({
          'messagingTokens': FieldValue.arrayUnion([messagingToken])
        });
      } catch (e) {
        log(e.toString());
      }
    }
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
          Icons.chat_rounded,
          color: Colors.white,
        ),
        title: "Chat",
        activeColorPrimary: kPrimaryColor,
        activeColorSecondary: Colors.white,
        inactiveIcon: const Icon(Icons.chat_rounded, color: Colors.grey),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kDarkColor,
      ),
      drawer: const Drawerr(),
      body: PersistentTabView(
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
      ),
    );
  }
}
