import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/constants.dart';

class Facts extends StatelessWidget {
  const Facts({super.key});

  @override
  Widget build(BuildContext context) {
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
            'Facts',
            style: TextStyle(
                color: Colors.white, fontFamily: 'Inter', fontSize: 25),
          ),
        ),
        // appBar: AppBar(
        //   title: const Text('Users Registered'),
        //   backgroundColor: kPrimaryColor,
        // ),

        body: Center(
          child: FutureBuilder(
            future: FirebaseFirestore.instance.collection('Facts').get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  // shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    QueryDocumentSnapshot<Map<String, dynamic>> document =
                        snapshot.data!.docs[index];
                  
                    return ListTile(
                      leading: Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(document['text'])),
                    );
                  },
                );
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
            },
          ),
        ));
  }
}
