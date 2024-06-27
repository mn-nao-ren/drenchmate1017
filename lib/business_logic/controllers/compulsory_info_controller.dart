import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:drenchmate_2024/presentation/screens/account_home_screen.dart';
import 'package:drenchmate_2024/business_logic/models/user_role_contact.dart';

class CompulsoryInfoController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController contactNumberController = TextEditingController();
  String? selectedRole;


  Future<void> registerAndSaveInfo(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        //String email = emailController.text.trim();

        // Register the user using FirebaseAuth
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: 'user@example.com', // Replace with actual email input from user
          password: 'password123',   // Replace with actual password input from user
        );
        User? user = userCredential.user;

        if (user != null) {
          UserRoleContact userInfo = UserRoleContact(
            contactNumber: contactNumberController.text,
            role: selectedRole ?? '',
          );

          if (userInfo.isValid()) {
            await FirebaseFirestore.instance.collection('users').doc(user.uid).set(userInfo.toMap(), SetOptions(merge: true));

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Information saved successfully')),
            );

            // Navigate to AccountHomeScreen
            Navigator.pushReplacementNamed(context, '/accountHome', arguments: user);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please fill in all required fields.')),
            );
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: $e')),
        );
      }
    }
  }
}