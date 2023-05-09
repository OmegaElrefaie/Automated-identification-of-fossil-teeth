// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/constants.dart';

class Drawerr extends StatefulWidget {
  const Drawerr({super.key});

  @override
  State<Drawerr> createState() => _DrawerrState();
}

class _DrawerrState extends State<Drawerr> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/asset1.png'),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Text(
                        'Dr Hesham Sallam',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Inter',
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'HeshamSallam@gmail.com',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Inter',
                            fontSize: 10,
                            fontWeight: FontWeight.w100),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          _createDrawerrItem(
              icon: Icons.settings,
              text: 'Settings',
              isSelected: selectedIndex == 0,
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
                context.pushNamed('settings_expert');
              }),
          _createDrawerrItem(
              icon: Icons.notifications,
              text: 'Notifications Editing',
              isSelected: selectedIndex == 2,
              onTap: () {
                setState(() {
                  selectedIndex = 2;
                });

                context.pushNamed('notifications_sending');
              }),
          _createDrawerrItem(
              icon: Icons.search_outlined,
              text: 'Add Fact',
              isSelected: selectedIndex == 3,
              onTap: () {
                setState(() {
                  selectedIndex = 3;
                });
                context.pushNamed('adding_facts');
              }),
          _createDrawerrItem(
              icon: Icons.timeline_rounded,
              text: 'Manage Maps',
              isSelected: selectedIndex == 3,
              onTap: () {
                setState(() {
                  selectedIndex = 3;
                });

                context.pushNamed('manage_maps');
              }),
        ],
      ),
    );
  }
}

Widget _createDrawerrItem(
    {IconData? icon,
    String? text,
    GestureTapCallback? onTap,
    bool? isSelected}) {
  return Ink(
    color: isSelected! ? kPrimaryColor : Colors.transparent,
    child: ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      selected: true,
      hoverColor: kLightColor,
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            color: isSelected ? Colors.white : Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              text!,
              style: TextStyle(color: isSelected ? Colors.white : Colors.black),
            ),
          )
        ],
      ),
      onTap: onTap,
    ),
  );
}
