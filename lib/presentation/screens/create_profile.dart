import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:drenchmate_2024/presentation/components/constants.dart';


class CreateProfileScreen extends StatelessWidget {
  static const String id = 'create_profile_Screen';
  final TextEditingController _profileNameController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  late final int profileID;
  late final int userID;
  late final String profileName;
  late final String permissions;
  late final DateTime createdAt;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CreateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Add edit functionality here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Specify your profile and profile-specific permissions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                profileName = value;
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Profile Name'),
            ),
            const SizedBox(height: 20),
            TextField( // permissions may be drop down field, not text field.
              textAlign: TextAlign.center,
              onChanged: (value) {
                permissions  = value;
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Specify Permissions'),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                // Add profile button pressed functionality here
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('CREATE'),
            ),
          ],
        ),
      ),
    );
  }
}
