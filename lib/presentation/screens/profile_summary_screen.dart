import 'package:flutter/material.dart';
import 'package:drenchmate_2024/presentation/components/user_card.dart';

class ProfileSummaryScreen extends StatelessWidget {
  static String id = "profile_summary_screen";
  // just an example, replace w widget that fetch from firestore
  final String userId = 'Billy Butcher';

  const ProfileSummaryScreen({super.key});

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
            icon: const Icon(Icons.notifications),
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
            const SizedBox(height: 20),

          ],
        ),

        ),
      );

  }

}