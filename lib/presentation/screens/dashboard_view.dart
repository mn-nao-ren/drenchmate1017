import 'package:flutter/material.dart';
import 'package:drenchmate_2024/presentation/components/highlight_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drenchmate_2024/presentation/components/bottom_navigation_bar.dart';

class DashboardScreen extends StatelessWidget {
  static const id = 'dashboard_screen';

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '      DrenchMate',
          style: GoogleFonts.lobster(
              color: Colors.black, fontSize: 35, fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.grey.shade400,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome back 👋',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              // John Doer is just a placeholder,
              // develop with stateful widget and fetch
              // do not use the following text widget
              const Text(
                'John Doer',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Overview',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'TUES 11 JUL',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              const Text(
                'Highlights',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  HighlightCard(
                    color: Colors.blueGrey.shade400,
                    icon: 'assets/icon/mob.png',
                    title: 'Mobs Info',
                    subtitle: 'display latest from db',
                    buttonText: 'Set up a Mob',
                    onButtonPressed: () {
                      // add actions
                    },
                  ),
                  HighlightCard(
                    color: Colors.black,
                    icon: 'assets/icon/drench.png',
                    title: "Drench Info",
                    subtitle: 'Next drenching in 30 days',
                    buttonText: 'Set up a Drench',
                    onButtonPressed: () {
                      // add action
                    },
                  ),
                  HighlightCard(
                    color: Colors.blue.shade900,
                    icon: 'assets/icon/property.png',
                    title: 'Property Info',
                    subtitle: '5 Mobs',
                    buttonText: 'Set up a Property',
                    onButtonPressed: () {
                      // add action
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      //how do you add a BottomNavigationBar properly here?
      bottomNavigationBar: const MyNavigationBar(),
    );
  }
}
