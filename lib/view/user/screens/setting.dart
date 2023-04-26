import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/data/repositories/authentication.dart';
import 'package:graduation_project/data/repositories/user_repo.dart';

UserRepository userRepo = UserRepository.instance;

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool s1 = false;

  String name = '';
  bool isloaded = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    name = await userRepo.getUserName();
    if (name.isNotEmpty) {
      setState(() {
        isloaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: const [
                  Center(
                    child: Text(
                      'Settings',
                      style: TextStyle(
                          color: kTextColor, fontFamily: 'Inter', fontSize: 30),
                    ),
                  ),
                ],
              ),
            ),
            Row(
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
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                )
              ],
            ),
            const Divider(height: 20, thickness: 1),
            Container(
              padding: const EdgeInsets.only(top: 0, left: 20),
              width: double.infinity,
              child: const Text(
                "Account Settings ",
                style: TextStyle(
                    height: 3,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Color.fromARGB(255, 168, 179, 171)),
              ),
            ),
            const SizedBox(height: 3),
            BuildAccountOption(context, "Edit profile"),
            BuildAccountOption(context, "Change password"),
            SwitchListTile(
              activeColor: const Color.fromRGBO(191, 89, 0, 1),
              value: s1,
              onChanged: (bool value) {
                setState(() {
                  s1 = value;
                });
              },
              title: const Text(
                'Push notification',
                style: TextStyle(fontSize: 22),
              ),
            ),
            const Divider(height: 2, thickness: 1),
            Container(
              padding: const EdgeInsets.only(top: 0, left: 20),
              width: double.infinity,
              child: const Text(
                "More ",
                style: TextStyle(
                    height: 3,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Color.fromARGB(255, 168, 179, 171)),
              ),
            ),
            const SizedBox(height: 3),
            BuildAccountOption(context, "About us"),
            BuildAccountOption(context, "Privacy policy"),
            BuildAccountOption(context, "Terms and conditions"),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: InkWell(
                onTap: () {
                  Auth().logout();
                  context.go('/login');
                },
                child: const Text(
                  "LogOut",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  GestureDetector BuildAccountOption(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        if (title == 'Edit profile') {
          context.go('/editprofile');
        } else if (title == 'Change password') {
          context.go('/change_password');
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey)
          ],
        ),
      ),
    );
  }
}
