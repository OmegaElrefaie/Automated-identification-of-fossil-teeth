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

  toJson() {
    return {
      'Email': email,
      'Username': username,
      'Profilepic': profilepic,
      'Type': type
    };
  }
}
