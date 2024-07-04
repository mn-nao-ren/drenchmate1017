import 'package:drenchmate_2024/business_logic/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileSummaryScreen extends StatefulWidget {
  static String id = "profile_summary_screen";
  // just an example, replace w widget that fetch from firestore
  final String userId = 'Billy Butcher';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Welcome back 👋'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserCard(userId: userId),
            SizedBox(height: 20),
            Text(
                'Recent Activities',
                style: TextStyle(
                  fontFamily: GoogleFonts.epilogue().fontFamily,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                )

            ),
            Expanded(
              child: ListView(
                children: [


                ],
              ),
            ),
          ],
        ),

        ),
      );

  }



}