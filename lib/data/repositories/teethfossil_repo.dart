import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:graduation_project/domain/fossil_model.dart';
import 'package:flutter/material.dart';


class FosssilRepository {
  static final FosssilRepository instance = FosssilRepository._();
  final db = FirebaseFirestore.instance;

  FosssilRepository._();


  // File? image;
  // Future<String>? imageurl;

  // Future<String> uploadImage() async {
  //   Future<String>? url;
  //   FirebaseStorage storage = FirebaseStorage.instance;
  //   Reference ref = storage.ref().child("images" + DateTime.now().toString());
  //   UploadTask uploadTask = ref.putFile(image!);
  //   uploadTask.whenComplete(() {
  //     url = ref.getDownloadURL();
  //   }).catchError((onError) {
  //     print(onError);
  //   });
  //   print(url);
  //   return url!;
    
  // }

  // Future<void> createFossil(Fossil fossil, String userId, String name, String imageUrl) async {
  //   try {
      // final docRef = FirebaseFirestore.instance
      //     .collection('Users')
      //     .doc(userId)
      //     .collection('Fossils')
      //     .doc(fossil.id);
      
  //     final data = {'name': name, 'imageUrl': imageUrl};
  //     await docRef.set(data);
  //     await docRef.update(fossil.toJson());
      
  //     print('Fossil added successfully!');
  //   } catch (e) {
  //     print('Failed to add fossil: $e');
  //   } 
  // }
  Future createFossil({
  required String name,
  required String imageUrl,
  required String id,
  required String userId,
}) async {
  final FossilInstance = FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('Fossils')
          .doc(id);

  final Data = {
    'name': name,
    'imageUrl': imageUrl,
  };
  await FossilInstance.set(Data);
}


  Future<String> getFossilId() async {
    List<String> fossilId = [];
    final snapShot =
        await db.collection('Fossils').limit(1).get().catchError((onError) {
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
    String id = await getFossilId();
    DocumentSnapshot fossil =
        await db.collection('Fossils').doc(id).get();

    fossilname = fossil.get('name');
    return fossilname;
  }

  Future<String> getImageUrl() async {
    String imageUrl;
    String id = await getFossilId();
    DocumentSnapshot fossil =
        await db.collection('Fossils').doc(id).get();

    imageUrl = fossil.get('imageUrl');
    return imageUrl;
  }

  Future fetchAllFossils() async {
    db.collection('Fossils').get();
  }

  Future removeFossil(String id) async {
    DocumentReference documentReference = db.collection('Fossils').doc(id);

    await documentReference.delete();
  }
}