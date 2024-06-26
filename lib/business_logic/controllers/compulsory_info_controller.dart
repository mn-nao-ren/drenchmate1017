import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drenchmate_2024/presentation/screens/account_home_screen.dart';
import 'package:drenchmate_2024/business_logic/models/user_role_contact.dart';

class CompulsoryInfoController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController contactNumberController = TextEditingController();
  String? selectedRole;

  Future<void> saveCompulsoryInfo(BuildContext context, User user) async {
    if (formKey.currentState!.validate()) {
      UserRoleContact userInfo = UserRoleContact(
        contactNumber: contactNumberController.text,
        role: selectedRole ?? '',
      );

      if (userInfo.isValid()) {
        try {
          await FirebaseFirestore.instance.collection('users').doc(user.uid).set(userInfo.toMap(), SetOptions(merge: true));

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Information saved successfully')),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AccountHomeScreen(user: user)),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to save information. Please try again later.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all required fields.')),
        );
      }
    }
  }
}