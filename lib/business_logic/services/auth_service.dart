import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:drenchmate_2024/business_logic/models/user_reg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> signIn({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user != null;
    } catch (e) {
      // error handling
      return false;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<bool> isUserAuthenticated() async {
    return _auth.currentUser != null;
  }

  Future<void> registerUser(UserReg user) async {
    await _firestore.collection('users').doc(user.email).set(user.toMap());
  }





  Future<User?> createAccount(BuildContext context, UserReg user) async {
    try {
      // Create user with Firebase Authentication

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully!')),
      );
      Navigator.pushReplacementNamed(context, '/compulsory_info');

      // add createdAt timestamp to user details
      user.createdAt = Timestamp.now();

      // Save user details to Firestore and wait for explicit confirmation


      // return user

    } on FirebaseAuthException catch (e) {

      String message;
      if (e.code == 'email-already-in-use') {
        message = 'The email is already in use.';
      } else if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else {
        message = 'Failed to create account: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
      return null;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
      return null;
    }
    return null;
  }

  // createAccount's encapsulated methods
  void _handleFirestoreSuccess(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Account created and data saved successfully!')),
    );
    // Optionally reset the form or navigate to another page
    Navigator.pushReplacementNamed(context, '/compulsory_info');
  }

  void _handleFirestoreError(BuildContext context, dynamic error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to save user data: $error')),
    );
  }
}