import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/data/repositories/authentication.dart';
import 'package:image_picker/image_picker.dart';

const double profileHeight = 155;

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _picker = ImagePicker();
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {});
    }
  }

  // ignore: non_constant_identifier_names
  bool isHiddenPassword_TFF1 = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: size.height * 0.25,
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
              padding: const EdgeInsets.only(right: 20.0, top: 20, left: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: () {
                          context.go('/settings'); //no navigation bar shows up
                        },
                        child: const Text(
                          'Settings',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontFamily: 'Inter',
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        )),
                    InkWell(
                        onTap: () {
                          Auth().logout();
                          context.go('/');
                        },
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontFamily: 'Inter',
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        )),
                  ]),
            ),
            Positioned(top: 90, right: 120, child: buildProfileImage()),
            Padding(
              padding: const EdgeInsets.only(left: 240, top: 170),
              child: FloatingActionButton(
                  onPressed: () {
                    _openImagePicker();
                  },
                  tooltip: 'Select Image',
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.photo_camera,
                      size: 25, color: kPrimaryColor)),
            ),
            Positioned(
                child: Row(
              children: const [
                SizedBox(height: 100),
                SizedBox(width: 100),
              ],
            )),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 250, horizontal: 75),
              child: const Text('Change Avatar',
                  style: TextStyle(
                    fontSize: 25,
                    color: Color.fromARGB(255, 11, 11, 11),
                    fontFamily: 'Inter',
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 300),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: TextFormField(
                  // controller: newNickname,
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
                    hintText: 'Change Nickname',
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 380),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: TextFormField(
                  obscureText: isHiddenPassword_TFF1,
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
                          isHiddenPassword_TFF1 = !isHiddenPassword_TFF1;
                        });
                      },
                      child: Icon(isHiddenPassword_TFF1
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    hintText: 'Confirm Password',
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 500, left: 115),
              width: 160,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  // ignore: deprecated_member_use
                  primary: const Color.fromRGBO(216, 139, 74, 1),
                  // ignore: deprecated_member_use
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35)),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget buildProfileImage() => Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              blurRadius: 10,
              color: Color.fromARGB(255, 253, 245, 245),
              spreadRadius: 10)
        ],
      ),
      child: const CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Color.fromARGB(255, 231, 220, 220),
        backgroundImage: AssetImage(
          'assets/images/asset4.png',
        ),
      ),
    );
// ignore: non_constant_identifier_names
Widget Background() => const CircleAvatar(
    radius: 70, backgroundColor: Color.fromRGBO(255, 255, 255, 0.863));
// ignore: non_constant_identifier_names
