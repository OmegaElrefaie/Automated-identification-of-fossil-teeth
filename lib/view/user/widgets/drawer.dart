import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/domain/user_model.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/data/repositories/user_repo.dart';

UserRepository userRepo = UserRepository.instance;

// ignore: must_be_immutable
class SideDrawer extends StatefulWidget {
  SideDrawer({super.key});
  UserModel user = UserModel();

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

int selectedIndex = 0;

class _SideDrawerState extends State<SideDrawer> {
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
                      padding: const EdgeInsets.only(top: 50),
                      child: InkWell(
                        onTap: () {
                          // print(usercontroller.myuser.value.username);
                        },
                        child: Text(
                          name,
                          // usercontroller.myuser.value.username == null
                          //     ? "Sara"
                          //     : usercontroller.myuser.value.username!,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        email,
                        // usercontroller.myuser.value.email == null
                        //     ? "Sara@gmail"
                        //     : usercontroller.myuser.value.email!,
                        style: const TextStyle(
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
              isSelected: selectedIndex == 3,
              onTap: () {
                setState(() {
                  selectedIndex = 3;
                });

                context.pushNamed('setting');
              }),
          _createDrawerItem(
              icon: Icons.search_outlined,
              text: 'Facts',
              isSelected: selectedIndex == 0,
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
                context.pushNamed('facts');
              }),
          _createDrawerItem(
              icon: Icons.chat_bubble_outline_rounded,
              text: 'Chat',
              isSelected: selectedIndex == 1,
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
                context.pushNamed('question');
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => const Question()));
              }),
          _createDrawerItem(
              icon: Icons.map_rounded,
              text: 'Map',
              isSelected: selectedIndex == 2,
              onTap: () {
                setState(() {
                  selectedIndex = 2;
                });

                context.pushNamed('fossil_map');
              }),
          _createDrawerItem(
              icon: Icons.timeline_rounded,
              text: 'Timeline',
              isSelected: selectedIndex == 3,
              onTap: () {
                setState(() {
                  selectedIndex = 3;
                });

                context.pushNamed('timeline_fossils');
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
