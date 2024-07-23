import 'package:drenchmate_2024/presentation/components/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:drenchmate_2024/business_logic/services/firestore_service.dart';
import 'package:drenchmate_2024/business_logic/models/profile.dart';

import 'dashboard_view.dart';

class ProfilePage extends StatefulWidget {
  static const id = 'profile_page';
  final FirestoreService firestoreService;
  final String userId;

  const ProfilePage({super.key, required this.firestoreService, required this.userId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final updatedProfile = Profile(
        userId: widget.userId,
        username: _nameController.text,
        email: _emailController.text,
        propertyId: '', // Assuming propertyId is not editable here; use the existing value if needed
        role: '', // Set the role if it is needed; otherwise, update it based on your logic
        permissions: [], // Provide default or existing permissions
        createdAt: DateTime.now(), // Use the current date or existing date
      );

      try {
        await widget.firestoreService.saveUserProfile(updatedProfile);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
        Navigator.pushNamed(context, DashboardScreen.id);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Profile>(
      future: widget.firestoreService.fetchUserProfile(widget.userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: const Text('Profile')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Profile')),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: const Text('Profile')),
            body: const Center(child: Text('No profile data found.')),
          );
        }

        Profile userProfile = snapshot.data!;
        _nameController.text = userProfile.username;
        _emailController.text = userProfile.email;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _saveProfile,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: const MyNavigationBar(),
        );
      },
    );
  }
}
