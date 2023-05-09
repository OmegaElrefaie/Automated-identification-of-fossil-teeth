import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_project/domain/facts_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

FactRepository factRepo = FactRepository.instance;

class FactRepository {
  static final FactRepository instance = FactRepository._();
  final db = FirebaseFirestore.instance;

  FactRepository._();

  Future createFact(Facts fact) async {
    final docUser = db.collection('Facts');
    final json = fact.toJson();

    await docUser.doc().set(json).catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: const Color.fromARGB(255, 255, 255, 255));
      return error("Error");
    });
  }

  Stream<List<Facts>> fetchFacts() {
    return FirebaseFirestore.instance
        .collection('Facts')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Facts(
                  text: doc['text'],
                ))
            .toList());
  }
}
