import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'infrastructure/network/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:drenchmate_2024/presentation/screens/authentication_screen.dart';
import 'package:drenchmate_2024/presentation/screens/treatment_screen.dart';
import 'package:drenchmate_2024/presentation/screens/home_landing_page.dart';
import 'package:drenchmate_2024/presentation/screens/dashboard_screen.dart';
import 'package:drenchmate_2024/presentation/screens/compulsory_info.dart';
import 'package:drenchmate_2024/presentation/screens/account_home_screen.dart';
import 'package:drenchmate_2024/presentation/screens/email_registration_page.dart';


void main() async {
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
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (context) => const HomePage(),
        RegistrationPage.id: (context) => const RegistrationPage(),
        AccountHomeScreen.id: (context) => AccountHomeScreen(),
      },
    );
  }
}

