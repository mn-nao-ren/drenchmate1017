import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'base_screen.dart';
import 'package:drenchmate_2024/business_logic/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  Future<void> initializeApp() async {
    await Firebase.initializeApp();
    checkAuthentication();
  }

  void checkAuthentication() async {
    bool isAuthenticated = await AuthService().isUserAuthenticated();
    if (isAuthenticated) {
      Navigator.pushReplacementNamed(context, '/treatment');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const BaseScreen(
      title: 'DrenchMate 2024',
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

