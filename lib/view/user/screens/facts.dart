import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:graduation_project/constants.dart';

class FactsScreen extends StatefulWidget {
  const FactsScreen({super.key});

  @override
  State<FactsScreen> createState() => _FactsScreenState();
}

class _FactsScreenState extends State<FactsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              context.go('/start_page');
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
          style:
              TextStyle(color: Colors.white, fontFamily: 'Inter', fontSize: 25),
        ),
      ),
      body: Center(
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection('Facts').get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  QueryDocumentSnapshot<Map<String, dynamic>> document =
                      snapshot.data!.docs[index];

                  return ListTile(
                    leading: Text(document['text']),
                  );
                },
              );
            }
            return Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
