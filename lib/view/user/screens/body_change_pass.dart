import 'package:flutter/material.dart';
import 'footer_change_pass.dart';
import 'header_change_pass.dart';

class ChangePassBody extends StatefulWidget {
  const ChangePassBody({super.key});

  @override
  State<ChangePassBody> createState() => _ChangePassBodyState();
}

class _ChangePassBodyState extends State<ChangePassBody> {
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
        //// body:  ChangePassBody();
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const HeaderChangePass(),
                //TextField == 1
                TextFormField(
                  controller: oldPass, //controller
                  obscureText: hide0,

                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    } else {
                      if (!regex.hasMatch(value)) {
                        return 'Enter valid password, password must contain letters, numbers and specail characters';
                      }
                    }
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
                    hintText: 'old Password',
                  ),
                ),
                const SizedBox(height: 15),

                //TextField == 2

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
                      hintText: 'new Password',
                      labelStyle: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey))),
                ),
                const SizedBox(height: 15),

                //TextField == 3
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
                    hintText: 'confirm new Password',
                  ),
                ),
                const SizedBox(height: 30),
                Footer(
                  newPass: newPass,
                  confirmPass: confirmPass,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
