import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:drenchmate_2024/presentation/components/rounded_button.dart';
import 'package:drenchmate_2024/presentation/components/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
                    const SizedBox(height: 20),
                    RoundedButton(
                      title: 'L og  In',
                      color: Colors.blue.shade500,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            bool isFirstLogin = prefs.getBool('first_login') ?? true;
                            if (isFirstLogin) {
                              await prefs.setBool('first_login', false);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Welcome to DrenchMate!'),
                                    content: const Text(
                                        'Step 1: Set up your property, your mobs, and their paddock numbers.\n'
                                            'Step 2: Enter Drenches.\n'
                                            'Step 3: Enter Worm Egg Count Results.\n'
                                            'Step 4: Await Advanced drench notifications.'
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Close'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                      ),
                                    ],

                                  );
                                },
                              );
                            }
                            Navigator.pushNamed(context, DashboardScreen.id);
                          } catch (e) {
                            // print(e);
                            // Show error message to the user if needed
                          } finally {
                            setState(() {
                              showSpinner = false;
                            });
                          }
                        }
                      },
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
