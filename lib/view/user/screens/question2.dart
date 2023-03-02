import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../constants.dart';

class Question2 extends StatefulWidget {
  const Question2({super.key});
  @override

  // ignore: library_private_types_in_public_api
  _Question2State createState() => _Question2State();
}

class _Question2State extends State<Question2> {
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
                context.go('/question');
              },
              child: const Icon(
               Icons.arrow_back,
               color: kTextColor,
                
              )),
        ),
            const Text(
              " Send Your Question ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: 2.5,
                  fontFamily: 'Inter',
                  fontSize: 30.0,
                  color: kTextColor), 
            ),
            const SizedBox(height: 35), 
             const Text(
              " No question sent yet ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: 4,
                  fontFamily: 'Inter',
                  fontSize: 19.0,
                  color: Colors.black), 
            ),
         Container(
            margin: const EdgeInsets.only(top: 20, right: 70,left: 70),
            width: 200,
            height: 45,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                // ignore: deprecated_member_use
                primary: const Color.fromARGB(255, 203, 123, 58),
                // ignore: deprecated_member_use
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text(
                'Answerd questions',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ), 
           const SizedBox(height: 130),
        Container(
             alignment: Alignment.center,
             padding: const EdgeInsets.all(20),
             child: Column(
               children: [
                   const TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 8,
                      decoration: InputDecoration( 
                         hintText: "Type here...",
                         focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Color.fromARGB(255, 149, 84, 0))
                         )
                      ),
                       
                   ),
                   Padding(
                     padding: const EdgeInsets.only(left:260),
                     child: ElevatedButton(
                       onPressed: (){}, 
                       child: const Icon(
                       Icons.send_outlined,
                       color: kTextColor, 
                       size: 23,
                     )
                 ),
                   )
               ],
             ),
          ),
        ],   
      ), 
    );
  }
}
