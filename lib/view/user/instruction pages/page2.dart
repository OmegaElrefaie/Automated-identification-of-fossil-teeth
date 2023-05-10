import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40, top: 5, bottom: 50),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    offset: const Offset(5, 5),
                    spreadRadius: 0.02,
                    blurStyle: BlurStyle.normal)
              ]),
          child: SizedBox(
            width: 800,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/instruction2.jpeg',
                        scale: 3.5,
                      ),
                    ),
                  ),
                  Container(color: kPrimaryColor),
                  const Padding(
                    padding: EdgeInsets.only(top: 100, left: 10, right: 10),
                    child: Text(
                        'Avoid objects in the background and choose a variant background color to the fossil tooth',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Inter',
                            fontSize: 15)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
