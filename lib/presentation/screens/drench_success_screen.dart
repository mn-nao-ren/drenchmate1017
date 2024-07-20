import 'package:flutter/material.dart';
import 'package:drenchmate_2024/presentation/components/bottom_navigation_bar.dart';

class DrenchSuccessPage extends StatelessWidget {
  static const String id = 'drench_success_page';

  const DrenchSuccessPage({super.key}); // Assign a route name for navigation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make the app bar transparent
        elevation: 0, // Remove the shadow/elevation
        automaticallyImplyLeading: false, // Remove the back button
      ),
      body: const Center(
        child: Column(
          children: [
            Text(
              'Drench Entry Saved Successfully!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            Text(
              'Tap on the Home button on the bottom navigation bar to go back to the Home screen dashboard!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

        ],
        ),
      ),
      bottomNavigationBar: const MyNavigationBar(),
    );
  }
}

