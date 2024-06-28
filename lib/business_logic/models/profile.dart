import 'package:cloud_firestore/cloud_firestore.dart';


class Profile {
  final int profileID;
  final int userID;
  final String profileName;
  final String permissions;
  final DateTime createdAt;

  Profile({
    required this.profileID,
    required this.userID,
    required this.profileName,
    required this.permissions,
    required this.createdAt,
  });

  // Factory constructor to create a Profile instance from a map
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      profileID: json['profileID'] as int,
      userID: json['userID'] as int,
      profileName: json['profileName'] as String,
      permissions: json['permissions'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  // Method to convert a Profile instance to a map
  Map<String, dynamic> toJson() {
    return {
      'profileID': profileID,
      'userID': userID,
      'profileName': profileName,
      'permissions': permissions,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Factory constructor to create a Profile instance from a map
  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      profileID: map['profileID'] as int,
      userID: map['userID'] as int,
      profileName: map['profileName'] as String,
      permissions: map['permissions'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  // Method to convert a Profile instance to a map
  Map<String, dynamic> toMap() {
    return {
      'profileID': profileID,
      'userID': userID,
      'profileName': profileName,
      'permissions': permissions,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
