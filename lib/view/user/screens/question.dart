import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/view/user/screens/chat.dart';
import '../../../constants.dart';
import '../../../domain/user_model.dart';


// ignore: must_be_immutable
class Question extends StatefulWidget {
 UserModel user;
  Question(this.user, {super.key});
  @override
  // ignore: library_private_types_in_public_api
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  TextEditingController searchController = TextEditingController();
  List<Map> searchResult =[];
  bool isLoading = false;

  void onSearch()async{
    setState(() {
      searchResult = [];
      isLoading = true;
    });
    await FirebaseFirestore.instance.collection('Users').where("Username",isEqualTo: searchController.text).get().then((value){
       if(value.docs.isEmpty){
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No User Found")));
            setState(() {
      isLoading = false;
    });
    return;
       }
       for (var user in value.docs) {
          if(user.data()['Email'] != widget.user.email){
               searchResult.add(user.data());
          }
        }
     setState(() {
      isLoading = false;
    });
    });
  }
  @override
  Widget build(BuildContext context) {
   //  Question();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Column(
          children: [
             const SizedBox(height: 60),
                 Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  context.go('/startpage');
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: kTextColor,
                ),
              ),
            ),
             const Text(
              "Ask experts in the field ",
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 2.5,
                fontFamily: 'Inter',
                fontSize: 30.0,
                color: kTextColor,
              ),
            ),
             const SizedBox(height: 23),
             Row(
               children: [
                 Expanded(
                   child: Padding(
                     padding: const EdgeInsets.all(5.0),
                     child: TextField(
                       controller: searchController,
                       decoration: InputDecoration(
                         hintText: "Search for user....",
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(10)
                         )
                       ),
                     ),
                   ),
                 ),
                 IconButton(onPressed: (){
                    onSearch();
                 }, icon: const Icon(Icons.search_outlined))
               ],
             ),
             const SizedBox(height: 23),
              SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 80,
              child: ElevatedButton(
                onPressed: () {
                  context.go('/chat');  
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 251, 252, 251),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
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
                          fontSize: 20.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
              //const SizedBox(height: 10),
             if(searchResult.isNotEmpty)
                Expanded(child: ListView.builder(
                  itemCount: searchResult.length,
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return ListTile(
                      // leading: CircleAvatar(
                      //   child: Image.network(searchResult[index]['image']),
                      // ),
                      title: Text(searchResult[index]['Username']),
                      subtitle: Text(searchResult[index]['Email']),
                      trailing: IconButton(onPressed: (){
                          setState(() {
                            searchController.text = "";
                          });
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>Question2(
                               currentUser: widget.user, 
                               friendId: searchResult[index]['id'],
                                friendName: searchResult[index]['Username'])));
                            //      friendImage: searchResult[index]['Profilepic'])));
                                   context.go('/chat');  
                      }, icon: const Icon(Icons.message_rounded)),
                    );
                  }))
             else if(isLoading == true)
                const Center(child: CircularProgressIndicator(),)
          ],
        ),
      ),  
    );
  }
}