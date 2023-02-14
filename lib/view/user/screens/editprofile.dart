import 'package:flutter/material.dart';


// import 'footer_edit_profile.dart';
// import 'header_edit_profile.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isHiddenPassword_TFF1 = true;

  final _formKey = GlobalKey<FormState>();
  final newNickname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          //EditProfileHeader(),
          Positioned(
              child: Row(
            children: const [
              SizedBox(height: 100), 
              SizedBox(width: 100), 
            ],
          )),
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: const Text('Edit Profile',
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                )),
          ),
          Container(
            margin: const EdgeInsets.only(top: 380),
            child: Padding(
              padding:const EdgeInsets.all(25),
              child: TextFormField(
                controller: newNickname,
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
                  hintText: 'New Username',
                ),
              ),
            ),
          ),
          Container(
            margin:const EdgeInsets.only(top: 450),
            child: Padding(
              padding:const EdgeInsets.all(25),
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
                  hintText: 'Enter Password',
                ),
              ),
            ),
          ),
          // EditProfileFooter(
          //   newNickname: newNickname,
          //   formKey: _formKey,
          // ),
          // Positioned(
          //   top: 640,
          //   left: 0,
          //   child: Image.asset('assets/images/Plant down left.png'),
          // ),
          Container(
            margin: const EdgeInsets.only(top: 600),
            width: 170,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  //when valiadted
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
              child: const Text(
                'Save',
                style: TextStyle(fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }
}
