// ignore_for_file: use_key_in_widget_constructors, avoid_web_libraries_in_flutter, must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/view/Admin/screens/widget/drawerwidget.dart';

class Headerr extends StatefulWidget {
  @override
  State<Headerr> createState() => _HeaderrState();
}

class _HeaderrState extends State<Headerr> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
        ),
        body: SizedBox(
            height: size.height * 0.3,
            child: Stack(children: <Widget>[
              Container(
                height: size.height * 0.3 - 27,
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36),
                  ),
                ),
                child: ListView(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage('assets/images/asset1.png'),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Dr Hesham Sallam',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Inter',
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      )
                    ],
                  ),
                ]),
              )
            ])),
        drawer: const Drawerr());
  }
}
