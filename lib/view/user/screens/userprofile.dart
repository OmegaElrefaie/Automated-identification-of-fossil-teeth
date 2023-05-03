import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/data/repositories/user_repo.dart';

UserRepository userRepo = UserRepository.instance;

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height * 0.40,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(47),
                    bottomRight: Radius.circular(47)),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [kDarkColor, kLightColor])),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 160.0),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 110,
                  backgroundImage: AssetImage('assets/images/asset4.png'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    name,
                    style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Inter',
                        fontSize: 23,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 100),
            child: Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: kTextColor,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 30.0, top: 550, right: 30, bottom: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.settings,
                      color: kTextColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        "Settings",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.logout,
                        color: kTextColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          FirebaseAuth.instance.signOut();
                        },
                        child: const Text(
                          "LogOut",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
