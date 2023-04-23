import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/constants.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

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
            padding: const EdgeInsets.only(left: 90, top: 160),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                CircleAvatar(
                  radius: 110,
                  backgroundImage: AssetImage('assets/images/asset4.png'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 410, left: 140),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Yosr Gamal',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Inter',
                      fontSize: 23,
                      fontWeight: FontWeight.w700),
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
                    context.go('/startpage');
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: kTextColor,
                  )),
            ),
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 30.0, top: 490),
                child: Icon(
                  Icons.settings,
                  color: kTextColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 490),
                child: InkWell(
                  onTap: () {},
                  child: const Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 30.0, top: 550),
                child: Icon(
                  Icons.logout,
                  color: kTextColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 550),
                child: InkWell(
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
