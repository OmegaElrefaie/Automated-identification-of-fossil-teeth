import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/data/repositories/user_repo.dart';
import 'package:graduation_project/view/user/screens/chat.dart';
import '../../../constants.dart';
import '../../../domain/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Question extends StatefulWidget {
  const Question({Key? key}) : super(key: key);

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  TextEditingController searchController = TextEditingController();
  List<Map> searchResult = [];
  Set<String> userIdsSearchResult = {};
  bool isLoading = false;
  String userId = UserRepository.instance.getFirebaseUid();

  void onSearch() async {
    setState(() {
      searchResult = [];
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('Users')
        .where("Username", isEqualTo: searchController.text)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No User Found")));
        setState(() {
          isLoading = false;
        });
        return;
      }
      for (var userDoc in value.docs) {
        if (userDoc.id != userId) {
          userIdsSearchResult.add(userDoc.id);
          searchResult.add(userDoc.data());
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
      appBar: AppBar(
        leading: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              context.pop();
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        elevation: 0,
        title: const Text(
          'Chat',
          style:
              TextStyle(color: Colors.white, fontFamily: 'Inter', fontSize: 22),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                          hintText: "Search...",
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey.shade600,
                            size: 20,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding: const EdgeInsets.all(8),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100))),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      onSearch();
                    },
                    icon: const Icon(Icons.search_outlined))
              ],
            ),
            if (searchResult.isEmpty)
              Expanded(
                  child: FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('Users')
                          .where('Email',
                              isNotEqualTo:
                                  FirebaseAuth.instance.currentUser!.email)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                QueryDocumentSnapshot<Map<String, dynamic>>
                                    document = snapshot.data!.docs[index];

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      searchController.text = "";
                                    });

                                    context.pushNamed('chat', queryParams: {
                                      'friendId': document.id,
                                      'friendName': document['Username'],
                                    });
                                    // context.pushNamed('chat', queryParams: {
                                    //   'friendId':
                                    //       userIdsSearchResult.elementAt(index),
                                    //   'friendName': searchResult[index]
                                    //       ['Username'],
                                    // });
                                  },
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      child:
                                          Image.network(document['Profilepic']),
                                    ),
                                    title: Text(document['Username']),
                                    subtitle: Text(document['Email']),
                                  ),
                                );
                              });
                        } else {
                          return Container(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                              ],
                            ),
                          );
                        }
                      }))
            else if (searchResult.isNotEmpty)
              ListView.builder(
                itemCount: searchResult.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        searchController.text = "";
                      });

                      context.pushNamed('chat', queryParams: {
                        'friendId': userIdsSearchResult.elementAt(index),
                        'friendName': searchResult[index]['Username'],
                      });
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Image.network(searchResult[index]['Profilepic']),
                      ),
                      title: Text(searchResult[index]['Username']),
                      subtitle: Text(searchResult[index]['Email']),
                    ),
                  );
                },
              )
          ],
        ),
      ),
    );
  }
}
