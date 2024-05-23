import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'infrastructure/network/firebase_options.dart';
import 'package:drenchmate_2024/presentation/screens/authentication_screen.dart';
import 'package:drenchmate_2024/presentation/screens/treatment_screen.dart';
import 'package:drenchmate_2024/presentation/screens/splash_screen.dart';
import 'package:drenchmate_2024/presentation/screens/dashboard_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const DrenchMateApp());
}

class DrenchMateApp extends StatelessWidget {
  const DrenchMateApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DrenchMate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => AuthenticationScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/treatment': (context) => const TreatmentScreen(),
      },
    );
  }
}