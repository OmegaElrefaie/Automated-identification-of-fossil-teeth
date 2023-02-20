class UserModel {
  String? id;
  String email;
  String username;
  String? password;
  String profilepic;

  UserModel({
    this.id,
    required this.email,
    required this.username,
    this.password,
    required this.profilepic,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        email: json['email'],
        username: json['username'],
        password: json['password'],
        profilepic: json['profilepic'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'password': password,
      'profilepic': profilepic,
    };
  }
}
