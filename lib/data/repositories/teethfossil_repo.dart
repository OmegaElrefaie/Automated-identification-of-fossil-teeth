import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:graduation_project/domain/fossil_model.dart';
import 'package:flutter/material.dart';

class FosssilRepository {
  static final FosssilRepository instance = FosssilRepository._();
  final db = FirebaseFirestore.instance;

  FosssilRepository._();

  Future createFossil(Fossil fossil, String uid) async {
    final docFossil= db.collection('Fossils');

    fossil.id = uid;
    final json = fossil.toJson();

    await docFossil.doc(uid).set(json).catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: const Color.fromARGB(255, 255, 255, 255));
      return error("Error");
    });
  }

  Future<String> getFossilId() async {
    List<String> fossilId = [];
    final snapShot = await FirebaseFirestore.instance
        .collection('Fossils')
        .limit(1)
        .get()
        .catchError((onError) {
      Get.snackbar(
        "Error",
        "An error occurred while retrieving data",
        colorText: Colors.white,
        backgroundColor: Colors.redAccent,
        barBlur: 10,
      );
    });

    for (var fossil in snapShot.docs) {
      fossilId.add(fossil.id);
    }

    return fossilId[0];
  }

  Future<String> getFossilName() async {
    String fossilname;
    String fossilid = await getFossilId();
    DocumentSnapshot fossil = await FirebaseFirestore.instance
        .collection('Fossils')
        .doc(fossilid)
        .get();

    fossilname = fossil.get('fossilname');
    return fossilname;
  }

  Future<String> getImageUrl() async {
    String imageUrl;
    String fossilid = await getFossilId();
    DocumentSnapshot fossil = await FirebaseFirestore.instance
        .collection('Fossils')
        .doc(fossilid)
        .get();

    imageUrl = fossil.get('Image');
    return imageUrl;
  }
}

