import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountHomeScreen extends StatefulWidget {
  static String id = 'account_home_screen';

  const AccountHomeScreen({super.key});
  @override
  _AccountHomeScreenState createState() => _AccountHomeScreenState();
}

class _AccountHomeScreenState extends State<AccountHomeScreen> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        //print(loggedInUser.email);
      }
    } catch (e) {
      //print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout_sharp),
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            }
          ),
        ],

        title: const Text('Account Home'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 20),
            ..._menuButtons.map((title) => _buildMenuButton(context, title)),
          ],
        ),
      ),
    );
  }

  final List<String> _menuButtons = [
    'Mob Status Overview',
    'Chemical Setup',
    'View Weather',
    'Drenching Setup',
    'Mob Setup',
    'Notifications',
    'Property Setup',
    'Profile Matters',
  ];

  Widget _buildMenuButton(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PlaceholderScreen(title)),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent, // Background color
          foregroundColor: Colors.white, // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          'This is the $title screen',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
