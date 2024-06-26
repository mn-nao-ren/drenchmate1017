import 'package:cloud_firestore/cloud_firestore.dart';

class UserReg {
  final String username;
  final String password;
  final String email;
  Timestamp createdAt;

  UserReg({required this.username, required this.password, required this.email, required this.createdAt});

  // Factory constructor to create a UserReg from a JSON object
  factory UserReg.fromJson(Map<String, dynamic> json) {
    return UserReg(
      username: json['username'],
      password: json['password'],
      email: json['email'],
      createdAt: json['createdAt'],
    );
  }

  // Method to convert UserReg instance to JSON object
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'CreatedAt': createdAt,
    };
  }
}
