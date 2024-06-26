import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:drenchmate_2024/presentation/screens/account_home_screen.dart';
import 'package:drenchmate_2024/business_logic/controllers/compulsory_info_controller.dart';

class CompulsoryInfoPage extends StatelessWidget {
  final CompulsoryInfoController controller = CompulsoryInfoController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _contactNumberController = TextEditingController();
  late final String? _selectedRole;

  CompulsoryInfoPage({super.key});

  Future<void> _saveCompulsoryInfo(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Get the current user ID
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Save the compulsory info to Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'contactNumber': _contactNumberController.text,
          'role': _selectedRole,
        }, SetOptions(merge: true));

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Information saved successfully')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AccountHomeScreen(user: user)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not logged in')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compulsory Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Role selection dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Select your role'),
                items: <String>['Farmer', 'Role 2', 'Role 3']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.selectedRole = value;
                },
                validator: (value) => value == null ? 'Please select a role' : null,
              ),
              const SizedBox(height: 20),
              // Contact number input
              TextFormField(
                controller: controller.contactNumberController,
                decoration: const InputDecoration(
                  labelText: 'Enter your contact number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your contact number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  User? user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    await controller.saveCompulsoryInfo(context, user);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('User not logged in')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
