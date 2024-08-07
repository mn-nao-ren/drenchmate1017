import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

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

  int profileID = 0;
  int userID = 0;
  String profileName = '';
  List<String> permissions = [];
  DateTime createdAt = DateTime.now();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> _permissionOptions = [
    "Create",
    "View",
    "Update",
    "Delete"
  ];
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create profile: $e'),
        ),
      );
    }

    setState(() {
      showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '        Profile Management',
          style: GoogleFonts.epilogue(
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
        ),
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
                const SizedBox(height: 12),
                Text(
                  'Add Profile',
                  style: GoogleFonts.epilogue(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _profileNameController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    hintText: 'Enter Profile Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 45),
                Text(
                  'Choose Permissions',
                  style: GoogleFonts.epilogue(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
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
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _createProfile,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.lightBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
