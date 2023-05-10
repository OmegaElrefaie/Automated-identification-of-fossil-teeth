import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/data/repositories/user_repo.dart';

UserRepository userRepo = UserRepository.instance;

class Drawerr extends StatefulWidget {
  const Drawerr({super.key});

  @override
  State<Drawerr> createState() => _DrawerrState();
}

int selectedIndex = 0;

class _DrawerrState extends State<Drawerr> {
  String name = '';
  String email = '';
  String imageUrl = '';
  bool isloaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    name = await userRepo.getUserName();
    email = await userRepo.getUserEmail();
    imageUrl = await userRepo.getUserPhoto();
    if (name.isNotEmpty) {
      setState(() {
        isloaded = true;
      });
    }
  }

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
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(imageUrl),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Text(
                        name,
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
                        email,
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
              text: 'Chat',
              isSelected: selectedIndex == 0,
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
                context.pushNamed('question');
              }),
          _createDrawerrItem(
              icon: Icons.notifications,
              text: 'Notifications Editing',
              isSelected: selectedIndex == 1,
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });

                context.pushNamed('notification_sending');
              }),
          _createDrawerrItem(
              icon: Icons.search_outlined,
              text: 'Add Fact',
              isSelected: selectedIndex == 2,
              onTap: () {
                setState(() {
                  selectedIndex = 2;
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
