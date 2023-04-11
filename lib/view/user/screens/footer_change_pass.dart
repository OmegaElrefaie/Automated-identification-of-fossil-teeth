import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key, required this.newPass, required this.confirmPass});
  final TextEditingController newPass;
  final TextEditingController confirmPass;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          width: 140,
          height: 45,
          child: ElevatedButton(
            onPressed: () {
              print(newPass.text);
              print(confirmPass.text);
              if (newPass.text.length > 6 || confirmPass.text.length > 6) {
                if (newPass.text == confirmPass.text) {
                  _changePassword(newPass.text);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                          content: Text('new passwords did not match.'));
                    },
                  );
                }
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      content: Text('Password should be at least 6 characters'),
                    );
                  },
                );
              }
            },
            style: ElevatedButton.styleFrom(
              // ignore: deprecated_member_use
              primary: const Color(0XFF588157),
              // ignore: deprecated_member_use
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
            child: const Text('Submit'),
          ),
        ),

        const SizedBox(height: 20), //the space before settings
        Align(
          alignment: Alignment.center,
          child: InkWell(
              //instead of TextField
              onTap: () {},
              child: const Text(
                'Forgot your password?',
                style: TextStyle(
                    color: Color.fromARGB(255, 124, 161, 126),
                    fontSize: 17,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold),
              )),
        ),
      ],
    );
  }
}

void _changePassword(String password) async {
  //Create an instance of the current user.
  var user = await FirebaseAuth.instance.currentUser!;

  //Pass in the password to updatePassword.
  user.updatePassword(password).then((_) {
    print("Successfully changed password");
  }).catchError((error) {
    print("Password can't be changed" + error.toString());
    //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
  });
}
