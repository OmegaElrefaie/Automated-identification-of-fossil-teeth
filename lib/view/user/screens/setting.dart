import 'package:flutter/material.dart';
import 'package:graduation_project/view/user/screens/changepassword.dart';
import 'package:graduation_project/view/user/screens/editprofile.dart';
import '../../../constants.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}
class _SettingState extends State<Setting> {
 bool s1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
               Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: const [
            Center(
              child: Text(
                'Setting',
                style: TextStyle(
                    color: kTextColor, fontFamily: 'Inter', fontSize: 30),
              ),
            ),
          ],
        ),
      ),
            Row(
                     mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/asset4.png'),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Yosr Gamal',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                )
              ],
               ),   
            const Divider(height: 20, thickness: 1),
             Container(
              padding: const EdgeInsets.only(top: 0, left: 20),
              width: double.infinity,
              child: const Text(
                "Account Settings ",
                style: TextStyle(
                    height: 3,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Color.fromARGB(255, 168, 179, 171)),
              ),
            ),
            const SizedBox(height: 3),
            BuildAccountOption(context, "Edit profile"),
            BuildAccountOption(context, "Change password"),
            SwitchListTile(
              activeColor: const Color.fromRGBO(191, 89, 0, 1),
              value: s1,
              onChanged: (bool value) {
                setState(() {
                  s1 = value;
                });
              },
              title: const Text(
                'Push notification',
                style: TextStyle(fontSize: 22),
              ),
            ),
            const Divider(height: 2, thickness: 1),
            
             Container(
              padding: const EdgeInsets.only(top: 0, left: 20),
              width: double.infinity,
              child: const Text(
                "More ",
                style: TextStyle(
                    height: 3,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Color.fromARGB(255, 168, 179, 171)),
              ),
            ),
            const SizedBox(height: 3),
            BuildAccountOption(context, "About us"),
            BuildAccountOption(context, "Privacy policy"),
            BuildAccountOption(context, "Terms and conditions"),
            
          ],
        ),
      ),
    );
  }
  // ignore: non_constant_identifier_names
  GestureDetector BuildAccountOption(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        if (title == 'Edit profile') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  EditProfile()),
          );
        } 
        else if (title == 'Change password') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>const ChangePassword()),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey)
          ],
        ),
      ),
    );
  }
}
