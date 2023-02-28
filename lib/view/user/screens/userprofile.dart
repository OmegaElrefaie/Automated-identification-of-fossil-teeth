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
            height: size.height * 0.55,
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
               padding: const EdgeInsets.all(40.0),
               child: Align(          
                    alignment: Alignment.topLeft,
                    child: InkWell(
                    onTap: () {
                  context.go('/');
                },
                child: const Icon(
                 Icons.arrow_back,
                 color: kTextColor,
                )),
            ),
          ),
        ],
      ),
    );
  }
}