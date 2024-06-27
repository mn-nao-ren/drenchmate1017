import 'package:cloud_firestore/cloud_firestore.dart';

class UserReg {
  final String username;
  final String password;
  final String email;
  Timestamp createdAt;
  String role;
  String contactNumber;


  UserReg({
    required this.username,
    required this.password,
    required this.email,
    required this.createdAt,
    required this.role,
    required this.contactNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'createdAt': createdAt,
      'role': role,
      'contactNumber': contactNumber,
    };
  }

  // Factory constructor to create a UserReg from a JSON object
  factory UserReg.fromJson(Map<String, dynamic> json) {
    return UserReg(
      username: json['username'],
      password: json['password'],
      email: json['email'],
      createdAt: json['createdAt'],
      role: json['role'],
      contactNumber: json['contactNumber'],
    );
  }

  // Method to convert UserReg instance to JSON object
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'createdAt': createdAt,
      'role': role,
      'contactNumber': contactNumber,
    };
  }
}
