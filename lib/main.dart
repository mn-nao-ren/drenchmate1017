import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'infrastructure/network/firebase_options.dart';
import 'package:drenchmate_2024/presentation/screens/home_landing_page.dart';
import 'package:drenchmate_2024/presentation/screens/account_home_screen.dart';
import 'package:drenchmate_2024/presentation/screens/email_registration_page.dart';
import 'package:drenchmate_2024/presentation/screens/dashboard_view.dart';
// import 'package:drenchmate_2024/presentation/screens/create_profile.dart'; // class name CreateProfileScreen

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
        AccountHomeScreen.id: (context) => const AccountHomeScreen(),
        DashboardScreen.id: (context) => DashboardScreen(),

        // CreateProfileScreen.id: (context) => const CreateProfileScreen(),
      },
    );
  }
}
