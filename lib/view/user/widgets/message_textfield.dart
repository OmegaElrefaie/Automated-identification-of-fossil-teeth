import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';

// ignore: must_be_immutable
class MessageTextField extends StatefulWidget {
  String currentId;
  final String friendId;

  MessageTextField(this.currentId, this.friendId, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MessageTextFieldState createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 61,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 3), blurRadius: 5, color: Colors.grey)
                  ]),
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    autofocus: false,
                    maxLines: null, // Allows the input field to accept multiple lines of text.
                    controller: _controller,
                    decoration: const InputDecoration(
                        hintText: "Type your Message...",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                        fillColor: Colors.white,
                        border: InputBorder.none),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      //Stores the user input message from the controller into a string variable.
                      String message = _controller.text; 
                      //Clears the input field after the message is sent.
                      _controller.clear();
                      await FirebaseFirestore.instance
                          .collection('Users')
                          .doc(widget.currentId)
                          .collection('messages')
                          .doc(widget.friendId)
                          .collection('chats')
                          .add({
                        "senderId": widget.currentId,
                        "receiverId": widget.friendId,
                        "message": message,
                        "type": "text",
                        "date": DateTime.now(),
                      }).then((value) {
                        FirebaseFirestore.instance
                            .collection('Users')
                            .doc(widget.currentId)
                            .collection('messages')
                            .doc(widget.friendId)
                            .set({
                          'last_msg': message,
                        });
                      });
   //perform these write operations and update the database with the new messages.
                      await FirebaseFirestore.instance
                          .collection('Users')
                          .doc(widget.friendId)
                          .collection('messages')
                          .doc(widget.currentId)
                          .collection("chats")
                          .add({
                        "senderId": widget.currentId,
                        "receiverId": widget.friendId,
                        "message": message,
                        "type": "text",
                        "date": DateTime.now(),
                      }).then((value) {
                        FirebaseFirestore.instance
                            .collection('Users')
                            .doc(widget.friendId)
                            .collection('messages')
                            .doc(widget.currentId)
                            .set({"last_msg": message});
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(9),
                      child: const Icon(
                        Icons.send_rounded,
                        color: kPrimaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
