import 'package:drenchmate_2024/presentation/screens/email_registration_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:drenchmate_2024/presentation/components/rounded_button.dart';
import 'package:drenchmate_2024/presentation/components/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'home_landing_page.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  final _formKey = GlobalKey<FormState>();
  bool showSpinner = false;

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> saveLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', true);
  }

  Future<void> saveFirstLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_first_time', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                      child: Image.asset(
                        'assets/round_logo.png',
                        height: 280,
                        width: 280,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Log In',
                      style: GoogleFonts.epilogue(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your email'),
                      validator: (value) =>
                      value!.isEmpty ? 'Email cannot be empty' : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: true,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your password'),
                      validator: (value) =>
                      value!.isEmpty ? 'Password cannot be empty' : null,
                    ),

                    const SizedBox(height: 7),

                    RoundedButton(
                      title: 'Log In',
                      color: Colors.blue.shade500,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            await saveLoginStatus();
                            await saveFirstLoginStatus();
                            Navigator.pushNamed(context, DashboardScreen.id);
                          } catch (e) {
                            // Handle error
                          } finally {
                            setState(() {
                              showSpinner = false;
                            });
                          }
                        }
                      },
                    ),

                    const SizedBox(height: 45),

                    Material(
                      elevation: 5.0,
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10.0),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, HomePage.id);
                        },
                        minWidth: 100.0,
                        height: 4.0,
                        child: const Text(
                          'Nah, take me to the Welcome page',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,

                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 11),

                    Material(
                      elevation: 5.0,
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10.0),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RegistrationPage.id);
                        },
                        minWidth: 100.0,
                        height: 14.0,
                        child: const Text(
                          'Nah, take me to the New User registration page',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,

                          ),
                        ),
                      ),
                    ),




                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
