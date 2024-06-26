import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountHomeScreen extends StatelessWidget{
  final User user;
  const AccountHomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('User data not found'));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;
          var username = userData['username'] ?? 'User';

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome, $username', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: [
                      _buildMenuButton(context, 'Mob Status Overview'),
                      _buildMenuButton(context, 'Chemical Setup'),
                      _buildMenuButton(context, 'View Weather'),
                      _buildMenuButton(context, 'Drenching Setup'),
                      _buildMenuButton(context, 'Mob Setup'),
                      _buildMenuButton(context, 'Notifications'),
                      _buildMenuButton(context, 'Property Setup'),
                      _buildMenuButton(context, 'Profile Matters'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String title) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to respective screens
      },
      child: Text(title, textAlign: TextAlign.center),
    );
  }

}