import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String username = "Loading...";

  @override
  void initState() {
    super.initState();
    fetchUsername();
  }


  Future<void> fetchUsername() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String uid = user.uid;
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
        setState(() {
          username = userDoc['username'];
        });
      } else {
        setState(() {
          username = "User not logged in";
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        username = "Error loading username";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      username,
      style: GoogleFonts.inconsolata(
        fontSize: 26,
          fontWeight: FontWeight.bold,
        color: Colors.black,
      ),

    );
  }
}
