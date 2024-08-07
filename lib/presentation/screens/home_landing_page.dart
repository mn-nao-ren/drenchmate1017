import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drenchmate_2024/presentation/screens/login_page.dart';



import 'email_registration_page.dart';



class HomePage extends StatelessWidget {

  const HomePage({super.key});

  static String id = 'home_page';

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
              ClipOval(
                child: Image.asset(
                    'assets/round_logo.png',
                    height: 320,
                    width: 320,
                    fit:BoxFit.cover
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Welcome to DrenchMate!',
                  style: GoogleFonts.lobster(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade900,
                  ),
                ),
              ),

              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  foregroundColor: Colors.white,
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
                label: const Text(
                    'Already have an account? Login Here!',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),
                ),
              ),
              const SizedBox(height: 10),
              const Text('or', style: TextStyle(fontSize: 16, color: Colors.blueGrey)),
              const SizedBox(height: 10),
              Text(
                'Create your account',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 10),
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


