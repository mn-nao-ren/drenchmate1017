
import 'package:drenchmate_2024/presentation/screens/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:drenchmate_2024/business_logic/services/auth_service.dart';
import 'package:drenchmate_2024/presentation/components/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';



class RegistrationPage extends StatefulWidget {
  static const String id = 'registration_page';

  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DrenchMate'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: const RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  late String username;
  late String email;
  late String password;
  late String? role;
  late String contactNumber;



  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreeToTerms = false;
  final AuthService _authService = AuthService();
  String? _selectedRole;

  Future<void> saveRegistrationStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_registered', true);
    await prefs.setBool('is_first_time', false);
  }




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            const SizedBox(height: 10),
            // DrenchMate logo
            Center(
              child: Image.asset(
                'assets/drenchmate_logo.png', // Update the path to your logo image
                height: 190,
              ),
            ),
            const SizedBox(height: 10),
            // Sign Up text
            Center(
              child: Text(
                'Sign Up',
                style: GoogleFonts.lobster(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                username = value;
              },
              decoration: 
                kTextFieldDecoration.copyWith(hintText: 'Enter your username'),
            ),
            const SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration:
                kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password'),
            ),

            const SizedBox(height: 20),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                contactNumber = value;
              },
              decoration:kTextFieldDecoration.copyWith(hintText: 'Enter your contact number'),
            ),

            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Select your role'),
              items: <String>['Farmer', 'Role 2', 'Role 3'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                role = value;
                setState(() {
                  _selectedRole = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select your role';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: _agreeToTerms,
                  onChanged: (bool? value) {
                    setState(() {
                      _agreeToTerms = value ?? false;
                    });
                  },
                ),
                const Text('I agree with'),
                GestureDetector(
                  onTap: () {
                    // Navigate to terms and conditions
                  },
                  child: const Text(
                    ' Terms & Conditions',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);

                    // Save additional user info to Firestore
                    await _firestore.collection('users').doc(newUser.user?.uid).set({
                      'username': username,
                      'email': email,
                      'contactNumber': contactNumber,
                      'role': role,
                    });

                    await saveRegistrationStatus();


                    Navigator.pushNamed(context, DashboardScreen.id);
                  } catch (e) {
                    // Handle errors appropriately
                    print(e);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to register: $e'),
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text('Register'),
            ),

          ],
        ),
      ),
    );
  }

}
