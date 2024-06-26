import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drenchmate_2024/presentation/screens/login_page.dart';



import 'email_registration_page.dart';

void main() {
  runApp(const DrenchMateApp());
}

class DrenchMateApp extends StatelessWidget {
  const DrenchMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drench Mate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/drench_mate_logo.jpg', height: 320),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Hello Mate!',
                  style: GoogleFonts.lobster(
                    fontSize: 37,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                ),
                onPressed: () {
                  // Handle login navigation
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                },
                icon: const Icon(Icons.login),
                label: const Text('Already have an account? Login Here!', style: TextStyle(fontSize: 15, color: Colors.white)),
              ),
              const SizedBox(height: 20),
              const Text('or', style: TextStyle(fontSize: 16, color: Colors.blueGrey)),
              Text(
                'Create your account',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialLoginButton(
                    icon: Icons.email,
                    color: Colors.red,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegistrationPage()),
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                  SocialLoginButton(
                    icon: Icons.apple,
                    color: Colors.black,
                    onPressed: () {
                      // Handle Apple login
                      //print("Apple login");
                    },
                  ),
                  const SizedBox(width: 20),
                  SocialLoginButton(
                    icon: Icons.phone,
                    color: Colors.green,
                    onPressed: () {
                      // Handle Phone login
                      //print("Phone login");
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const SocialLoginButton({super.key, required this.icon, required this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        radius: 30,
        backgroundColor: color,
        child: Icon(icon, color: Colors.white, size: 30),
      ),
    );
  }
}


