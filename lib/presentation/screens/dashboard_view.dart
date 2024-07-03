import 'package:flutter/material.dart';
import 'package:drenchmate_2024/presentation/components/highlight_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drenchmate_2024/presentation/components/bottom_navigation_bar.dart';
import 'package:drenchmate_2024/presentation/screens/create_profile.dart';
import 'package:drenchmate_2024/presentation/screens/generate_report_screen.dart';
import 'package:drenchmate_2024/presentation/screens/setup_property_screen.dart';

class DashboardScreen extends StatelessWidget {
  static const id = 'dashboard_screen';

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // iconTheme: ,
        title: Row(
          children: [
            const SizedBox(height: 40, width: 14),
            ClipOval(child: Image.asset('assets/icon/mob.png', height: 40, width: 40)),
            Text(
            ' DrenchMate',
            style: GoogleFonts.lobster(
                color: Colors.white, fontSize: 35, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        backgroundColor: Colors.blueGrey.shade600, //Colors.blue.shade900,
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
                'User',
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
              SingleChildScrollView(
                child: GridView.count(
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
                        Navigator.pushNamed(context, SetupPropertyScreen.id);
                      },
                    ),
                    HighlightCard(
                      color: Colors.blueGrey.shade400,
                      icon: 'assets/icon/profile.png',
                      title: 'Profile',
                      subtitle: 'Add, restrict actions',
                      buttonText: 'Create a Profile',
                      onButtonPressed: () {
                        // add actions
                        Navigator.pushNamed(context, CreateProfileScreen.id);
                      },
                    ),

                    // this one is actually for generate report

                    HighlightCard(
                      color: Colors.black,
                      icon: 'assets/icon/generate_report.png',
                      title: "Reports",
                      subtitle: 'Backed-up logs for gov', // replace w data display widget soon
                      buttonText: 'Generate Report',
                      onButtonPressed: () {
                        // add action
                        Navigator.pushNamed(context, GenerateReportScreen.id);
                      },
                    ),

                  ],
                ),
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
