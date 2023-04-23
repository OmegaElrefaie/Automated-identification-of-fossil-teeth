import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/view/user/screens/question2.dart';
import '../../../constants.dart';

class Question extends StatefulWidget {
  const Question({super.key});
  @override

  // ignore: library_private_types_in_public_api
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(17),
        children: [
          const SizedBox(height: 55),
          Align(
            alignment: Alignment.topLeft,
            child: InkWell(
                onTap: () {
                  context.go('/');
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: kTextColor,
                )),
          ),
          const Text(
            "Ask experts in the field",
            textAlign: TextAlign.center,
            style: TextStyle(
                height: 2.5,
                fontFamily: 'Inter',
                fontSize: 25.0,
                color: kTextColor),
          ),
          const SizedBox(height: 35),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 80,
            child: ElevatedButton(
              onPressed: () {
                //         Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Question2(currentUser: null, friendId: '', friendImage: '', friendName: '',)),
                // );
                context.go('/question2');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 251, 252, 251),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/asset1.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Dr. Hesham Sallam",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15.0,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
