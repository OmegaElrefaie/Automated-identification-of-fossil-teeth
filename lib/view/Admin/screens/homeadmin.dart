// ignore_for_file: use_key_in_widget_constructors, avoid_web_libraries_in_flutter, must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/constants.dart';

class Headerr extends StatefulWidget {
  @override
  State<Headerr> createState() => _HeaderrState();
}

class _HeaderrState extends State<Headerr> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int selectedIndex = 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
      ),
      body: SizedBox(
          height: size.height * 0.3,
          child: Stack(children: <Widget>[
            Container(
              height: size.height * 0.3 - 27,
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
              ),
              child: ListView(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/asset1.png'),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Dr Hesham Sallam',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    )
                  ],
                ),
              ]),
            )
          ])),
      drawer: Drawer(
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
            _createDrawerItem(
                icon: Icons.settings,
                text: 'Settings',
                isSelected: selectedIndex == 0,
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                  });
                  context.go('/');
                }),
            _createDrawerItem(
                icon: Icons.phone,
                text: 'Support',
                isSelected: selectedIndex == 2,
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                  });

                  Navigator.pushReplacementNamed(context, "/");
                }),
          ],
        ),
      ),
    );
  }
}

Widget _createDrawerItem(
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
