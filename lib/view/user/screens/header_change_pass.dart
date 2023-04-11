import 'package:flutter/material.dart';

class HeaderChangePass extends StatelessWidget {
  const HeaderChangePass({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30), //the space before settings
        Align(
          alignment: Alignment.topLeft,
          child: InkWell(
              //instead of Textbutton
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Settings',
                style: TextStyle(
                    color: Color.fromARGB(255, 124, 161, 126),
                    fontFamily: 'Inter',
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),
        ),
        const SizedBox(height: 35), //space before change password text
        const Text('Change Password',
            style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 52, 78, 65),
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 35),
      ],
    );
  }
}
