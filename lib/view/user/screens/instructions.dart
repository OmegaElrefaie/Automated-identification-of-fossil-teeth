import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/view/user/instruction pages/page1.dart';
import 'package:graduation_project/view/user/instruction pages/page2.dart';
import 'package:graduation_project/view/user/instruction pages/page3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

bool isChecked = false;

class Instructions extends StatefulWidget {
  Instructions({super.key});

  @override
  State<Instructions> createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return kPrimaryColor;
      }
      return kDarkColor;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Align(
          child: InkWell(
            onTap: () async {
              await SessionManager().get('id').then((value) {
                if (value == null)
                  context.go('/identify');
                else
                  context.pushNamed('displayresults');
              });
            },
            child: const Icon(
              Icons.close_rounded,
              color: kDarkColor,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(children: [
        SizedBox(
            height: 500,
            child: PageView(
              controller: _controller,
              children: const [
                Page1(),
                Page2(),
                Page3(),
              ],
            )),
        SmoothPageIndicator(
          controller: _controller,
          count: 3,
          effect: JumpingDotEffect(
              activeDotColor: kPrimaryColor,
              dotColor: Colors.grey.shade500,
              spacing: 15,
              verticalOffset: 5),
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              Text(
                'do not show again',
                style: TextStyle(color: kTextColor, fontSize: 11),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
