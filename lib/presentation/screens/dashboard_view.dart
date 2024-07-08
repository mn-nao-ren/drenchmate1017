import 'package:drenchmate_2024/presentation/screens/chemical_entry_screen.dart';
import 'package:flutter/material.dart';
import 'package:drenchmate_2024/presentation/components/highlight_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drenchmate_2024/presentation/components/bottom_navigation_bar.dart';
import 'package:drenchmate_2024/presentation/screens/create_profile.dart';
import 'package:drenchmate_2024/presentation/screens/generate_report_screen.dart';
import 'package:drenchmate_2024/presentation/screens/setup_property_screen.dart';
import 'package:drenchmate_2024/presentation/screens/drench_entry_screen.dart';
import 'package:drenchmate_2024/presentation/screens/create_mob_page.dart';
import 'package:drenchmate_2024/presentation/components/username.dart';
import 'package:intl/intl.dart';


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
            const SizedBox(height: 40, width: 12),
            ClipOval(child: Image.asset('assets/round_logo.png', height: 40, width: 41)),
            Text(
            ' DrenchMate',
            style: GoogleFonts.lobster(
                color: Colors.white, fontSize: 35, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        backgroundColor: Colors.blueGrey.shade800,
        foregroundColor: Colors.white,//Colors.blue.shade900,
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
              Text(
                'Welcome back 👋',
                style: GoogleFonts.lobster(
                    fontSize: 29,
                    fontWeight: FontWeight.w500
                ),
              ),

              const UserProfile(),

              const SizedBox(height: 20),


              Text(
                'Overview',
                style: GoogleFonts.roboto(fontSize: 26, fontWeight: FontWeight.w600),
              ),



              Text(
                DateFormat('EEE d MMM').format(DateTime.now()).toUpperCase(),
                style: TextStyle(fontSize: 20, color: Colors.grey.shade600),

              ),

              const SizedBox(height: 20),



              const Text(
                'Highlights',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 9),


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
                      icon: 'assets/weather.png',
                      title: 'Weather Info',
                      subtitle: 'Monitored, alerts set',
                      buttonText: 'placeholder',
                      onButtonPressed: () {

                      },
                    ),
                    HighlightCard(
                      color: Colors.lightBlue.shade500,
                      icon: 'assets/icon/mob.png',
                      title: 'Mobs Info',
                      subtitle: 'display latest from db',
                      buttonText: 'Set up a Mob',
                      onButtonPressed: () {
                        // add actions
                        Navigator.pushNamed(context, CreateMobPage.id);
                      },
                    ),
                    HighlightCard(
                      color: Colors.blue.shade900,
                      icon: 'assets/icon/drench.png',
                      title: "Drench Info",
                      subtitle: 'Upcoming Drenches',
                      buttonText: 'Set up a Drench',
                      onButtonPressed: () {
                        Navigator.pushNamed(context, DrenchEntryScreen.id);
                      },
                    ),
                    HighlightCard(
                      color: Colors.blueGrey.shade400,
                      icon: 'assets/icon/property.png',
                      title: 'Property Info',
                      subtitle: 'Your farm property info',
                      buttonText: 'Set up a Property',
                      onButtonPressed: () {
                        Navigator.pushNamed(context, SetupPropertyScreen.id);
                      },
                    ),
                    HighlightCard(
                      color: Colors.lightBlue.shade500,
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
                      color: Colors.blue.shade900,
                      icon: 'assets/icon/generate_report.png',
                      title: "Reports",
                      subtitle: 'Backed-up logs for gov', // replace w data display widget soon
                      buttonText: 'Generate Report',
                      onButtonPressed: () {
                        // add action
                        Navigator.pushNamed(context, GenerateReportScreen.id);
                      },
                    ),

                    HighlightCard(
                      color: Colors.blueGrey.shade400,
                      icon: 'assets/icon/property.png',
                      title: 'Manage Products',
                      subtitle: 'Chemical compositions',
                      buttonText: 'Enter a new product',
                      onButtonPressed: () {
                        Navigator.pushNamed(context, ChemicalEntryScreen.id);
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
