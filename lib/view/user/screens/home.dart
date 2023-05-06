import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            padding: const EdgeInsets.only(left: 270),
            child: FloatingActionButton(
                onPressed: () {
                  context.pushNamed('userprofile');
                },
                backgroundColor: kPrimaryColor,
                child: const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/asset4.png'),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Column(
              children: [
                const Text(
                  'Fact of the day',
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Inter', fontSize: 20),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 64,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        'The first dinosaur fossil was found around 1815',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Inter',
                            fontSize: 15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                GestureDetector(
                  onTap: () {
                    // context.go('/displayresults');
                    context.pushNamed('instructions');
                  },
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      height: 200,
                      width: 200,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(29, 0, 0, 0),
                              blurRadius: 4.0,
                              spreadRadius: 0,
                              offset: Offset(
                                5,
                                5,
                              ))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 20),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Image.asset(
                              'assets/images/searchicon.png',
                              scale: 2.5,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Tap to Identify',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Inter',
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
      // drawer: const SideDrawer(),
    );
  }
}
