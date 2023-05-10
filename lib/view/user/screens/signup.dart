import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/domain/user_model.dart';
import 'package:graduation_project/view/user/screens/startpage.dart';
import 'package:graduation_project/view/user/widgets/getcolor.dart';
import 'package:graduation_project/data/repositories/user_repo.dart';
import 'package:graduation_project/data/repositories/authentication.dart';

UserRepository userRepo = UserRepository.instance;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  bool isHiddenPassword = true;
  final formKey = GlobalKey<FormState>();

  Future handleSignUp() async {
    if (!formKey.currentState!.validate()) return;
    final email = _emailcontroller.text.trim();
    final password = _passwordcontroller.text.trim();
    try {
      await Auth()
          .registerUsingEmailPassword(
              context: context, email: email, password: password)
          .then((authUser) {
        final user = UserModel(
            email: _emailcontroller.text.trim(),
            username: _usernamecontroller.text.trim(),
            profilepic: '',
            type: 'User');

        if (authUser != null) {
          print('user created');
          userRepo.createUser(user, authUser.uid);
          context.go('/login');
        }
      });
    } on FirebaseAuthException catch (e) {
      context.go('/signup');
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(SignUpController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Signup',
          style: TextStyle(
              color: kDarkColor,
              fontFamily: 'Inter',
              fontSize: 25,
              fontWeight: FontWeight.w100),
        ),
        actions: [
          InkWell(
            onTap: () {
              context.go('/login');
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Center(
                child: Text(
                  'Login',
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
                      controller: _usernamecontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your username";
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
                          hintText: 'Username',
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
                      controller: _emailcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        }
                        return null;
                      },
                      obscureText: isHiddenPassword,
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
                        onPressed: () {
                          handleSignUp();
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                getColor(kPrimaryColor, kTextColor),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)))),
                        child: const Text(
                          'Sign Up',
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
