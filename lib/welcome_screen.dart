import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/constants.dart';
import 'package:animated_icon/animate_icon.dart';
import 'package:animated_icon/animate_icons.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:graduation_project/data/repositories/user_repo.dart';
import 'package:graduation_project/view/user/screens/instructions.dart';

UserRepository userRepo = UserRepository.instance;

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Future<void> userRole() async {
    if (await userRepo.getUserType() == 'User') {
      context.go('/startpage');
    } else {
      context.go('/home_expert');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 30.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 180,
                width: 300,
                child: Image(
                  image: AssetImage('assets/images/splash.png'),
                  fit: BoxFit.contain,
                ),
              ),
              Column(
                children: [
                  const Text(
                    'Fossil Scratcher',
                    style: TextStyle(
                        color: kTextColor,
                        fontFamily: 'PathwayExtreme',
                        fontSize: 25,
                        fontWeight: FontWeight.w700),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 30),
                        child: const Text(
                          'Discover and Identify your collection of fossil teeth by just one click',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'PathwayExtreme',
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      AnimateIcon(
                        key: UniqueKey(),
                        onTap: () {},
                        iconType: IconType.continueAnimation,
                        height: 70,
                        width: 70,
                        color: Colors.black12,
                        animateIcon: AnimateIcons.downArrow,
                      ),
                      SizedBox(height: 5),
                      const Text(
                        'Identify as Guest',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'PathwayExtreme',
                            fontSize: 15),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          if (isChecked == true) {
                            context.pushNamed('identify');
                          } else {
                            context.pushNamed('instructions');
                          }
                          // context.go('/displayresults');
                        },
                        child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            height: 60,
                            width: 60,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(60)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Image.asset(
                                    'assets/images/searchicon.png',
                                    scale: 3.5,
                                  ),
                                ],
                              ),
                            )),
                      ),
                      SizedBox(height: 60),
                      const Text(
                        '- OR -',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'PathwayExtreme',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: BorderSide(color: kPrimaryColor)),
                            onPressed: () async {
                              await SessionManager().get('id').then((value) {
                                if (value == null)
                                  context.pushNamed('login');
                                else
                                  userRole();
                                // context.pushNamed('startpage');
                              });
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'PathwayExtreme',
                                  fontSize: 15),
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: BorderSide(color: kPrimaryColor)),
                            onPressed: () {
                              context.go('/signup');
                            },
                            child: const Text(
                              'Signup',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'PathwayExtreme',
                                  fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      // AnimatedTextKit(
                      //   animatedTexts: [
                      //     WavyAnimatedText(
                      //       'Get Started',
                      //       textStyle: const TextStyle(
                      //         fontSize: 15.0,
                      //         fontWeight: FontWeight.w800,
                      //       ),
                      //       speed: const Duration(milliseconds: 500),
                      //     ),
                      //   ],
                      //   isRepeatingAnimation: true,
                      //   repeatForever: true,
                      //   displayFullTextOnTap: true,
                      //   onTap: () async {
                      //     await SessionManager().get('id').then((value) {
                      //       if (value == null)
                      //         context.pushNamed('login');
                      //       else
                      //         userRole();
                      //       // context.pushNamed('startpage');
                      //     });
                      //   },
                      // )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
