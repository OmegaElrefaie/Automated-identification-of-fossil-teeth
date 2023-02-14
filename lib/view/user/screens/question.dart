import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
                color: Color.fromARGB(255, 207, 111, 2),
                
              )),
        ),
            const Text(
              "Ask experst in the field ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: 2.5,
                  fontFamily: 'Inter',
                  fontSize: 30.0,
                  color: Color.fromARGB(255, 204, 122, 0)),
                
            ),
           
          ],
          
        ), 
    );
  }

}
