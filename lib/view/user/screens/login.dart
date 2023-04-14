import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/data/repositories/authentication.dart';
import 'package:graduation_project/data/repositories/user_repo.dart';
import 'package:graduation_project/view/user/screens/signup.dart';
import 'package:graduation_project/view/user/screens/startpage.dart';
import 'package:graduation_project/view/user/widgets/getcolor.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:graduation_project/domain/user_model.dart';

UserRepository userRepo = UserRepository.instance;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool isHiddenPassword = true;
  final formKey = GlobalKey<FormState>();
  // final GlobalKey<FormState> formKey = GlobalKey();

  Future handleLogIn() async {
    final email = _emailcontroller.text.trim();
    final password = _passwordcontroller.text.trim();
    print('object');
    Auth()
        .signInUsingEmailPassword(
            context: context, email: email, password: password)
        .then((authUser) {
      initializeUser(authUser);
    });
  }

  Future<void> initializeUser(User? authUser) async {
    if (authUser == null) {
      print('user is signed out');
      context.go('/');
    } else {
      context.go('/startpage');
      print('user is signed in');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(LogInController());
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
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
                          if (formKey.currentState!.validate()) {
                            await handleLogIn();
                          }

                          // StreamBuilder<User?>(
                          //   stream: FirebaseAuth.instance.authStateChanges(),
                          //   builder: (context, snapshot) {
                          //     if (snapshot.hasData) {
                          //       return const StartPage();
                          //     } else {
                          //       return const Signup();
                          //     }
                          //   },
                          // );

                          // LogInController.instance.logInUser(
                          //     controller.email.text.trim(),
                          //     controller.password.text.trim());
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
                    )
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
