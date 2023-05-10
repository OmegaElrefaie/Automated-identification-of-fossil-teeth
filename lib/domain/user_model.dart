import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? email;
  String? username;
  String? password;
  String? profilepic;
  String? type;

  UserModel(
      {this.id,
      this.email,
      this.username,
      this.password,
      this.profilepic,
      this.type});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      email: json['Email'],
      username: json['Username'],
      profilepic: json['Profilepic'],
      type: json['Type']);

  // factory UserModel.fromSnapshot(
  //     DocumentSnapshot<Map<String, dynamic>> document) {
  //   final data = document.data();
  //   return UserModel(
  //       id: document.id,
  //       email: data!['Email'],
  //       username: data['Username'],
  //       profilepic: data['Profilepic'],
  //       type: data['Type']);
  // }

  // UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
  //   email = doc['Email'];
  //   username = doc['Username'];
  //   profilepic = doc['Profilepic'];
  //   type = doc['Type'];
  // }

  toJson() {
    return {
      'Email': email,
      'Username': username,
      'Profilepic': profilepic,
      'Type': type
    };
  }
}
