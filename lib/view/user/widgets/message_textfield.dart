import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class MessageTextField extends StatefulWidget {
   String currentId;
  final String friendId;

   MessageTextField(this.currentId,this.friendId, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MessageTextFieldState createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
       color: Colors.white,
       padding:const EdgeInsetsDirectional.all(8),
       child: Row(
         children: [
           Expanded(child: TextField(
             controller: _controller,
              decoration: InputDecoration(
                labelText:"Type your Message...",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  gapPadding: 10,
                  borderRadius: BorderRadius.circular(10)
                )
              ),
           )),
           const SizedBox(width: 10,),
           GestureDetector(
             onTap: ()async{
               String message = _controller.text;
               _controller.clear();
               await FirebaseFirestore.instance.collection('users').doc(widget.currentId).collection('messages').doc(widget.friendId).collection('chats').add({
                  "senderId":widget.currentId,
                  "receiverId":widget.friendId,
                  "message":message,
                  "type":"text",
                  "date":DateTime.now(),
               }).then((value) {
                 FirebaseFirestore.instance.collection('users').doc(widget.currentId).collection('messages').doc(widget.friendId).set({
                     'last_msg':message,
                 });
               });

               await FirebaseFirestore.instance.collection('users').doc(widget.friendId).collection('messages').doc(widget.currentId).collection("chats").add({
                 "senderId":widget.currentId,
                 "receiverId":widget.friendId,
                 "message":message,
                 "type":"text",
                 "date":DateTime.now(),

               }).then((value){
                 FirebaseFirestore.instance.collection('users').doc(widget.friendId).collection('messages').doc(widget.currentId).set({
                   "last_msg":message
                 });
               });
             },
             child: Container(
               padding:const EdgeInsets.all(9),
               decoration:const BoxDecoration(
                shape: BoxShape.circle,
                 color: Color.fromARGB(255, 178, 118, 39),
               ),
               child:const Icon(Icons.send_outlined,color: Colors.white,),
             ),
           )
         ],
       ),
      
    );
  }
}