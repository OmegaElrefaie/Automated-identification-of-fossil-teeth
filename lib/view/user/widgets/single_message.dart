import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class SingleMessage extends StatelessWidget {
  final String message;
  final bool isMe;    //check wether the message is sent by the user or not.
  const SingleMessage({super.key, required this.message, required this.isMe});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        ChatBubble(
          clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
          alignment: Alignment.topRight,
          margin: const EdgeInsets.only(top: 20),
          backGroundColor: isMe ? kPrimaryColor : kDarkColor,
          child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                ),
              )),
        ),

        // Container(
        //     padding: const EdgeInsets.all(16),
        //     margin: const EdgeInsets.all(16),
        //     constraints: const BoxConstraints(maxWidth: 200),
        //     decoration: BoxDecoration(
        //         color: isMe ? kPrimaryColor : kDarkColor,
        //         borderRadius: const BorderRadius.all(Radius.circular(12))),
        //     child: Text(
        //       message,
        //       style: const TextStyle(
        //         color: Colors.white,
        //       ),
        //     )),
      ],
    );
  }
}
