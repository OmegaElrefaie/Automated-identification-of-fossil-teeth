import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/view/user/screens/facts.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

int selectedIndex = 0;

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
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
                  backgroundImage: AssetImage('assets/images/asset4.png'),
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
                        'Yosr Gamal',
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
                        'yosrgamal@gmail.com',
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
              icon: Icons.search_outlined,
              text: 'Facts',
              isSelected: selectedIndex == 0,
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
               context.go('/facts');
              }),
          _createDrawerItem(
              icon: Icons.history,
              text: 'Q/A',
              isSelected: selectedIndex == 1,
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });

               context.go('/question');
              }),
          _createDrawerItem(
              icon: Icons.help,
              text: 'Help & Support',
              isSelected: selectedIndex == 2,
              onTap: () {
                setState(() {
                  selectedIndex = 2;
                });

                Navigator.pushReplacementNamed(context, "/page2");
              }),
        ],
      ),
    );
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
                style:
                    TextStyle(color: isSelected ? Colors.white : Colors.black),
              ),
            )
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
