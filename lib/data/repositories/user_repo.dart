import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:graduation_project/domain/user_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  static final UserRepository instance = UserRepository._();
  final db = FirebaseFirestore.instance;

  UserRepository._();

  Future createUser(UserModel user, String uid) async {
    final docUser = db.collection('Users');

    user.id = uid;
    final json = user.toJson();

    await docUser.doc(uid).set(json).catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: const Color.fromARGB(255, 255, 255, 255));
      return error("Error");
    });

    // await _db
    //     .collection("Users")
    //     .add(user.toJson())
    //     .whenComplete(() => Get.snackbar(
    //         "Success", "Your account has been created",
    //         snackPosition: SnackPosition.BOTTOM,
    //         backgroundColor: Colors.green,
    //         colorText: const Color.fromARGB(255, 255, 255, 255)))
    //     .catchError((error, stackTrace) {
    //   Get.snackbar("Error", "Something went wrong. Try again",
    //       snackPosition: SnackPosition.BOTTOM,
    //       backgroundColor: Colors.redAccent,
    //       colorText: const Color.fromARGB(255, 255, 255, 255));
    //   return error("Error");
    // });
  }

  // Future<UserModel?> fetchUserData(String uid) async {
  //  try { return await db.collection('Users').get().then((snapshot) {
  //     Map<String, dynamic> user =
  //         jsonDecode(jsonEncode(snapshot)) as Map<String, dynamic>;
  //     user['uid'] = uid;
  //     return UserModel.fromJson(user);
  //   });
  //   } catch (e) {
  //     print(e.toString());
  //   }
//}
  ///function malhash lazma khales bet2ra bs
  Future<String> getUserId() async {
    List<String> userId = [];
    final snapShot = await FirebaseFirestore.instance
        .collection('Users')
        .where('Email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
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

    for (var user in snapShot.docs) {
      userId.add(user.id);
    }

    return userId[0];
  }

  String getFirebaseUid() {
    return FirebaseAuth.instance.currentUser?.uid ?? "";
  }

  Future<String> getUserName() async {
    String username;
    String myuserid = await getUserId();
    DocumentSnapshot user = await FirebaseFirestore.instance
        .collection('Users')
        .doc(myuserid)
        .get();

    username = user.get('Username');
    return username;
  }

  Future<String> getUserEmail() async {
    String email;
    String myuserid = await getUserId();
    DocumentSnapshot user = await FirebaseFirestore.instance
        .collection('Users')
        .doc(myuserid)
        .get();

    email = user.get('Email');
    return email;
  }

  Future<String> getUserPhoto() async {
    String image;
    String myuserid = await getUserId();
    DocumentSnapshot user = await FirebaseFirestore.instance
        .collection('Users')
        .doc(myuserid)
        .get();

    image = user.get('ImageUrl');
    return image;
  }

  Future<String> getUserType() async {
    String userType;
    String myuserid = await getUserId();
    DocumentSnapshot user = await FirebaseFirestore.instance
        .collection('Users')
        .doc(myuserid)
        .get();

    userType = user.get('Type');
    return userType;
  }

  Future<void> updateUserName(String newUserName) async {
    print('in');
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userRef = FirebaseFirestore.instance.collection('Users').doc(userId);

    await userRef.update({
      'Username': newUserName,
    });

    print('out');
  }

  Future<void> deleteAccount() async {
    // Get the current user ID
    final userId = FirebaseAuth.instance.currentUser!.uid;

    try {
      // Delete the user's account

      // Delete the user's document from Firestore
      await FirebaseFirestore.instance.collection('Users').doc(userId).delete();

      await FirebaseAuth.instance.currentUser!.delete();
    } catch (e) {
      // Handle any errors that may occur during the deletion process
      print('Error deleting account: $e');
    }
  }
}
