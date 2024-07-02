import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:drenchmate_2024/presentation/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drenchmate_2024/business_logic/models/profile.dart';

class CreateProfileScreen extends StatefulWidget {
  static const String id = 'create_profile_Screen';

  const CreateProfileScreen({super.key});

  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {

  final TextEditingController _profileNameController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  late final int profileID;
  late final int userID;
  late final String profileName;
  late List<String> permissions = [];
  late final DateTime createdAt;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> _permissionOptions = ["Create", "View", "Update", "Delete"];
  final Map<String, bool> _selectedPermissions = {
    "Create": false,
    "View": false,
    "Update": false,
    "Delete": false,
  };

  void _onPermissionChanged(String permission, bool? selected) {
    setState(() {
      _selectedPermissions[permission] = selected ?? false;
      permissions = _selectedPermissions.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();
    });
  }

  // method that uses _auth to create profile and save to database
  Future<void> _createProfile() async {
    setState(() {
      showSpinner = true;
    });

    try {
      final user = _auth.currentUser;
      if (user != null) {
        final uid = user.uid;
        await FirebaseFirestore.instance.collection('profiles').add({
          'profileName': _profileNameController.text,
          'permissions': permissions,
          'userID': uid,
          'createdAt': Timestamp.now(),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile Created for You'),
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      print(e);
    }

    setState(() {
      showSpinner = false;
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
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
                const Text(
                  'Choose Permissions',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView(
                    children: _permissionOptions.map((permission) {
                      return CheckboxListTile(
                        title: Text(permission),
                        value: _selectedPermissions[permission],
                        onChanged: (bool? selected) {
                          setState(() {
                            _onPermissionChanged(permission, selected);
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _createProfile,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('CREATE'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}