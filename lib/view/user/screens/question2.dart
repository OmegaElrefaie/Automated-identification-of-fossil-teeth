import 'package:go_router/go_router.dart';
import 'package:graduation_project/domain/user_model.dart';
import 'package:graduation_project/view/user/widgets/message_textfield.dart';
import 'package:graduation_project/view/user/widgets/single_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class Question2 extends StatelessWidget {
  final UserModel currentUser;
  final String friendId;
  final String friendName;
  final String friendImage;
  
Question2({
  required this.friendId,
  required this.friendName,
  required this.friendImage,
  required this.currentUser,
});

  
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding:const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: (){
                  context.go('/question');
                  },
                  icon:const Icon(Icons.arrow_back, color: kTextColor,),
                ),
                const SizedBox(width: 2,),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/asset1.png'),
                  maxRadius: 35,
                ),
                const SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text("Dr. Hesham Sallam",style: TextStyle( fontSize: 18 ,fontWeight: FontWeight.w600),),
                      SizedBox(height: 6,),
                      //Text("Online",style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),
                    ],
                  ),
                ),
                //const Icon(Icons.settings,color: Colors.black54,),
              ],
            ),
          ),
        ),
      ),

      body: Column(
        children: [
           Expanded(child: Container(
             padding:const EdgeInsets.all(10),
             decoration: const BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(25),
                 topRight: Radius.circular(25)
               )
             ),
             
             child: StreamBuilder(
              stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(currentUser.id)
                    .collection('messages')
                    .doc(friendId)
                    .collection('chats')
                    .orderBy("date", descending: true)
                    .snapshots(),
               builder: (context,AsyncSnapshot snapshot){
                   if(snapshot.hasData){
                     if(snapshot.data.docs.length < 1){
                       return const Center(
                         child: Text("No questions yet"),
                       );
                     }
                     return ListView.builder(
                       itemCount: snapshot.data.docs.length,
                       reverse: true,
                       physics: const BouncingScrollPhysics(),
                       itemBuilder: (context,index){
                          bool isMe = snapshot.data.docs[index]['senderId'] == currentUser.id;
                          return SingleMessage(message: snapshot.data.docs[index]['message'], isMe: isMe);
                       });
                   }
                   return const Center(
                     child: CircularProgressIndicator()
                   );
               }),
           )),
          MessageTextField(currentUser.id ?? "", friendId),
        ],
      ),
      
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import '../../../constants.dart';
// class Question2 extends StatefulWidget {
//   const Question2({super.key});
//   @override
//   // ignore: library_private_types_in_public_api
//   _Question2State createState() => _Question2State();
// }

// class ChatMessage{
//   String messageContent;
//   String messageType;
//   ChatMessage({required this.messageContent, required this.messageType});
// }
// List<ChatMessage> messages = [
//     ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
//     ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
//     ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
//     ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
//     ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
//   ];
  
// class _Question2State extends State<Question2> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.white,
      //   flexibleSpace: SafeArea(
      //     child: Container(
      //       padding:const EdgeInsets.only(right: 16),
      //       child: Row(
      //         children: <Widget>[
      //           IconButton(
      //             onPressed: (){
      //             context.go('/question');
      //             },
      //             icon:const Icon(Icons.arrow_back, color: kTextColor,),
      //           ),
      //           const SizedBox(width: 2,),
      //           const CircleAvatar(
      //             backgroundImage: AssetImage('assets/images/asset1.png'),
      //             maxRadius: 35,
      //           ),
      //           const SizedBox(width: 12,),
      //           Expanded(
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: const <Widget>[
      //                 Text("Dr. Hesham Sallam",style: TextStyle( fontSize: 18 ,fontWeight: FontWeight.w600),),
      //                 SizedBox(height: 6,),
      //                 //Text("Online",style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),
      //               ],
      //             ),
      //           ),
      //           //const Icon(Icons.settings,color: Colors.black54,),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
//       body: Stack(
//         children: <Widget>[
//           Align(
//             alignment: Alignment.bottomLeft,
//             child: Container(
//               padding:const EdgeInsets.only(left: 10,bottom: 10,top: 10),
//               height: 70,
//               width: double.infinity,
//               color: Colors.white,
//               child: Row(
//                 children: <Widget>[
//                   GestureDetector(
//                     onTap: (){
//                     },
//                     child: Container(
//                       height: 30,
//                       width: 30,
//                       decoration: BoxDecoration(
//                        color: kTextColor,
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child:const Icon(Icons.add, color: Colors.white, size: 20, ),
//                     ),
//                   ),
//                   const SizedBox(width: 15,),
//                   const Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: "Write message...",
//                         hintStyle: TextStyle(color: Colors.black54),
//                         border: InputBorder.none
//                       ),
//                     ),
//                   ),
//                  // const SizedBox(width: 15,),
//                   FloatingActionButton(
//                     onPressed: (){},
//                     backgroundColor:const Color.fromARGB(255, 140, 77, 15),
//                     elevation: 0,
//                     child:const Icon( Icons.send_outlined,color: Colors.white,size: 18,),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
    
    // return Scaffold(
    //   body: ListView(
    //       padding: const EdgeInsets.all(17),
    //       children: [  
    //          const SizedBox(height: 55),
    //           Align(          
    //               alignment: Alignment.topLeft,
    //               child: InkWell(
    //               onTap: () {
    //             context.go('/question');
    //           },
    //           child: const Icon(
    //            Icons.arrow_back,
    //            color: kTextColor,
                
    //           )),
    //     ),
    //         const Text(
    //           " Send Your Question ",
    //           textAlign: TextAlign.center,
    //           style: TextStyle(
    //               height: 2.5,
    //               fontFamily: 'Inter',
    //               fontSize: 30.0,
    //               color: kTextColor), 
    //         ),
    //         const SizedBox(height: 200), 
    //          const Text(
    //           " No question sent yet ",
    //           textAlign: TextAlign.center,
    //           style: TextStyle(
    //               height: 4,
    //               fontFamily: 'Inter',
    //               fontSize: 19.0,
    //               color: Colors.black), 
    //         ),
    //     //  Container(
    //     //     margin: const EdgeInsets.only(top: 20, right: 70,left: 70),
    //     //     width: 200,
    //     //     height: 45,
    //     //     child: ElevatedButton(
    //     //       onPressed: () {},
    //     //       style: ElevatedButton.styleFrom(
    //     //         // ignore: deprecated_member_use
    //     //         primary: const Color.fromARGB(255, 203, 123, 58),
    //     //         // ignore: deprecated_member_use
    //     //         onPrimary: Colors.white,
    //     //         shape: RoundedRectangleBorder(
    //     //             borderRadius: BorderRadius.circular(10)),
    //     //       ),
    //     //       child: const Text(
    //     //         'Answerd questions',
    //     //         style: TextStyle(fontSize: 18),
    //     //       ),
    //     //     ),
    //     //   ), 
    //        const SizedBox(height: 180),
    //     Container(
    //          alignment: Alignment.center,
    //          padding: const EdgeInsets.all(20),
    //          child: Column(
    //            children: [
    //                const TextField(
    //                   keyboardType: TextInputType.multiline,
    //                   maxLines: 2,
    //                   decoration: InputDecoration( 
    //                      hintText: "Type here...",
    //                      focusedBorder: OutlineInputBorder(
    //                         borderSide: BorderSide(width: 1, color: Color.fromARGB(255, 149, 84, 0))
    //                      )
    //                   ),
                       
    //                ),
    //                 const SizedBox(height: 7),
    //                Padding(
    //                  padding: const EdgeInsets.only(left:260),
    //                  child: ElevatedButton(
    //                    onPressed: (){}, 
    //                    child: const Icon(
    //                    Icons.send_outlined,
    //                    color: kTextColor, 
    //                    size: 23,
    //                  )
    //              ),
    //                )
    //            ],
    //          ),
    //       ),
    //     ],   
    //   ), 
    // );
//   }
// }

