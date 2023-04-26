// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  bool hide0 = true;
  bool hide1 = true;
  bool hide2 = true;

  final oldPass = TextEditingController();
  final newPass = TextEditingController();
  final confirmPass = TextEditingController();
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~])');
  @override
  void dispose() {
    oldPass.dispose();
    newPass.dispose();
    confirmPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 30), //the space before settings
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Settings',
                        style: TextStyle(
                          color: kTextColor,
                          fontFamily: 'Inter',
                          fontSize: 18,
                        ),
                      )),
                ),
                const SizedBox(height: 35), //space before change password text
                const Text('Change Password',
                    style: TextStyle(
                      fontSize: 30,
                      color: kTextColor,
                      fontFamily: 'Inter',
                    )),
                const SizedBox(height: 35),
                TextFormField(
                  controller: oldPass,
                  obscureText: hide0,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    } else {
                      if (!regex.hasMatch(value)) {
                        return 'Enter valid password, password must contain letters, numbers and specail characters';
                      }
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
                          hide0 = !hide0;
                        });
                      },
                      child:
                          Icon(hide0 ? Icons.visibility_off : Icons.visibility),
                    ),
                    hintText: 'Old Password',
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: newPass,
                  obscureText: hide1,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
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
                            hide1 = !hide1;
                          });
                        },
                        child: Icon(
                            hide1 ? Icons.visibility_off : Icons.visibility),
                      ),
                      hintText: 'New Password',
                      labelStyle: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey))),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: confirmPass,
                  obscureText: hide2,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    } else {
                      if (!regex.hasMatch(value)) {
                        return 'Enter valid password, password must contain letters, numbers and specail characters';
                      }
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
                          hide2 = !hide2;
                        });
                      },
                      child:
                          Icon(hide2 ? Icons.visibility_off : Icons.visibility),
                    ),
                    hintText: 'Confirm Password',
                  ),
                ),
                const SizedBox(height: 28),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50.0, vertical: 15.0),
                    // ignore: deprecated_member_use
                    primary: const Color.fromRGBO(216, 139, 74, 1),
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                      onTap: () {},
                      child: const Text(
                        'Forgot your password?',
                        style: TextStyle(
                          color: kTextColor,
                          fontSize: 17,
                          fontFamily: 'Inter',
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
