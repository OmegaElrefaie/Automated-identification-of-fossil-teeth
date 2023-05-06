import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/data/repositories/authentication.dart';
import 'package:graduation_project/data/repositories/user_repo.dart';
import 'package:graduation_project/domain/user_model.dart';
import 'package:graduation_project/view/expert/screens/chat_expert.dart';
import 'package:graduation_project/view/user/screens/startpage.dart';
import 'package:graduation_project/view/user/widgets/getcolor.dart';

UserRepository userRepo = UserRepository.instance;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // User? authUser;
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool isHiddenPassword = true;
  final formKey = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   super.initState();

  //   FirebaseAuth.instance.authStateChanges().listen((event) {
  //     updateUserState(event);
  //   });
  // }

  // updateUserState(event) {
  //   setState(() {
  //     authUser = event;
  //   });
  // }

  // final GlobalKey<FormState> formKey = GlobalKey();

  Future handleLogIn() async {
    final email = _emailcontroller.text.trim();
    final password = _passwordcontroller.text.trim();
    Auth()
        .signInUsingEmailPassword(
            context: context, email: email, password: password)
        .then((authUser) {
      initializeUser(authUser);
    });
  }

  Future googleLogIn() async {
    Auth().googleSignIn(context: context).then((authUser) {
      initializeUser(authUser);
    });
  }

  Future<void> userRole() async {
    if (await userRepo.getUserType() == 'User') {
      context.go('/startpage');
    } else {
      context.go('/home_expert');
    }
  }

  Future<void> initializeUser(User? authUser) async {
    if (authUser == null) {
      if (kDebugMode) {
        print('user is signed out');
      }
      context.go('/login');
    } else {
      userRole();
      // context.go('/startpage');
      if (kDebugMode) {
        print('user is signed in');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            color: kDarkColor,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.go('/');
            }),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Login',
          style: TextStyle(
              color: kDarkColor,
              fontFamily: 'Inter',
              fontSize: 25,
              fontWeight: FontWeight.w100),
        ),
        actions: [
          InkWell(
            onTap: () {
              // Get.toNamed('/signup');
              context.go('/signup');
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Center(
                child: Text(
                  'Signup',
                  style: TextStyle(
                      color: kDarkColor,
                      fontFamily: 'Inter',
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15, top: 80),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _emailcontroller,
                      // controller.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: const Color(0XFFF6F6F6),
                          hintText: 'Email',
                          hintStyle: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              color: Color(0XFFBDBDBD)),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color(0XFFE8E8E8)))),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: _passwordcontroller,
                      // controller.password,
                      obscureText: isHiddenPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isHiddenPassword = !isHiddenPassword;
                              });
                            },
                            child: Icon(isHiddenPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          fillColor: const Color(0XFFF6F6F6),
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              color: Color(0XFFBDBDBD)),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color(0XFFE8E8E8)))),
                    ),
                    const SizedBox(
                      height: 100.0,
                    ),
                    SizedBox(
                      height: 40,
                      width: 400,
                      child: ElevatedButton(
                        onPressed: () async {
                          // if (formKey.currentState!.validate()) {}
                          googleLogIn();
                        },
                        style: ButtonStyle(
                            backgroundColor: getColor(Colors.white, kTextColor),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)))),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Ink.image(
                              image:
                                  AssetImage('assets/images/google-logo.png'),
                              height: 25,
                              width: 25,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            const Text(
                              'Sign in with Google',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Inter',
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 40,
                      width: 400,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await handleLogIn();
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                getColor(kPrimaryColor, kTextColor),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)))),
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Inter',
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
