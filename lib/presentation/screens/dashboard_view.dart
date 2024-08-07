import 'dart:async';
import 'package:drenchmate_2024/presentation/screens/chemical_entry_screen.dart';
import 'package:drenchmate_2024/presentation/screens/enter_egg_test_results.dart';
import 'package:drenchmate_2024/presentation/screens/view_egg_results_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:drenchmate_2024/presentation/components/highlight_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drenchmate_2024/presentation/components/bottom_navigation_bar.dart';
import 'package:drenchmate_2024/presentation/screens/setup_property_screen.dart';
import 'package:drenchmate_2024/presentation/screens/view_egg_results_page.dart';
import 'package:drenchmate_2024/presentation/screens/drench_entry_screen.dart';
import 'package:drenchmate_2024/presentation/screens/create_mob_page.dart';
import 'package:drenchmate_2024/presentation/components/username.dart';
import 'package:intl/intl.dart';
import 'package:drenchmate_2024/presentation/components/first_steps_popup.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:drenchmate_2024/presentation/screens/mobs_view.dart';
import '../../business_logic/services/advanced_notice_logic.dart';
import 'login_page.dart';

class DashboardScreen extends StatefulWidget {
  static const id = 'dashboard_screen';

  const DashboardScreen({super.key});
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final int _currentIndex = 0;
  late Timer _timer;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final noticeHandler = Provider.of<NoticeHandler>(context, listen: false);
      noticeHandler.checkConditions();
    });

    // _timer = Timer.periodic(const Duration(hours: 1), (timer) {
    //   // logic for getting values for last drench date, egg count, weather conditions,
    //   // and effective period days
    // });
  }



  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 24),
                ClipOval(
                    child: Image.asset('assets/round_logo.png',
                        height: 42, width: 42)),
                Text(
                  ' DrenchMate',
                  style: GoogleFonts.lobster(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.blueGrey.shade800,
          foregroundColor: Colors.white, //Colors.blue.shade900,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app_sharp),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('is_logged_in', false);
                Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id, (route) => false);
              },
            ),

          ],
          automaticallyImplyLeading: false,
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                       Flexible(
                         child: Text(
                                               'Welcome back👋',
                                               style: GoogleFonts.lobster(
                            fontSize: 29, fontWeight: FontWeight.normal),
                                             ),
                       ),

                    const SizedBox(width: 24),

                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const FirstStepsPopup();
                          },
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 9.0),
                        backgroundColor: Colors.teal.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.double_arrow,
                            color: Colors.teal.shade900,
                          ),

                          const SizedBox(width: 1),


                          Text(
                            'FIRST STEPS',
                            style: TextStyle(
                              color: Colors.teal.shade900,
                              fontFamily: 'Source Sans Pro',
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const Row(
                    children: [
                       SizedBox(width: 16),
                       UserProfile(),
                    ]
                ),


                const SizedBox(height: 24),
                Text(
                  'Overview',
                  style: GoogleFonts.epilogue(
                      color: Colors.black,
                      fontSize: 25, fontWeight: FontWeight.w700
                  )
                ),
                // const SizedBox(height: 8),

                // the Row with the date
                Row(

                  children: [
                    const Icon(Icons.sunny),
                    const SizedBox(width: 17),
                    Text(
                      DateFormat('EEE d MMM').format(DateTime.now()).toUpperCase(),
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600
                      ),
                    ),
                  ],

                ),

                const SizedBox(height: 28),

               Text(
                    'Highlights',
                    style: GoogleFonts.epilogue(
                      color: Colors.black,
                        fontSize: 23, fontWeight: FontWeight.bold
                    )

                  ),


                const SizedBox(height: 4),
                SingleChildScrollView(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 39,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // HighlightCard(
                      //   color: Colors.blueGrey.shade400,
                      //   icon: 'assets/weather.png',
                      //   title: 'Weather Info',
                      //   subtitle: 'Monitored, alerts set',
                      //   buttonText: 'OpenWeather',
                      //   onTap: () {},
                      //   onButtonPressed: () {},
                      // ),
                      HighlightCard(
                        color: Colors.blueGrey.shade400,
                        icon: 'assets/icon/mob.png',
                        title: 'Mobs Info',
                        subtitle: 'display latest from db',
                        buttonText: 'Set up a Mob',
                        onTap: () {
                          Navigator.pushNamed(context, MobsView.id);
                        },
                        onButtonPressed: () {
                          Navigator.pushNamed(context, CreateMobPage.id);
                        },
                      ),
                      HighlightCard(
                        color: Colors.lightBlue.shade500,
                        icon: 'assets/icon/drench.png',
                        title: "Drench Info",
                        subtitle: 'Upcoming Drenches',
                        buttonText: 'Enter a Drench',
                        onTap: () {},
                        onButtonPressed: () {
                          Navigator.pushNamed(context, DrenchEntryScreen.id);
                        },
                      ),
                      HighlightCard(
                        color: Colors.blue.shade900,
                        icon: 'assets/icon/property.png',
                        title: 'Property Info',
                        subtitle: 'Your farm property info',
                        buttonText: 'Set up a Property',
                        onTap: () {},
                        onButtonPressed: () {
                          Navigator.pushNamed(context, SetupPropertyScreen.id);
                        },
                      ),


                      HighlightCard(
                        color: Colors.blueGrey.shade400,
                        icon: 'assets/icon/property.png',
                        title: 'Products',
                        subtitle: 'Chemical compositions',
                        buttonText: 'Enter a new product',
                        onTap: () {},
                        onButtonPressed: () {
                          Navigator.pushNamed(context, ChemicalEntryScreen.id);
                        },
                      ),
                      HighlightCard(
                        color: Colors.lightBlue.shade500,
                        icon: 'assets/icon/mob.png',
                        title: 'Parasite Test',
                        subtitle: 'Worm egg counts',
                        buttonText: 'Enter results',
                        onTap: () {
                          Navigator.pushNamed(context, ViewEggResultsPage.id);
                        },
                        onButtonPressed: () {
                          Navigator.pushNamed(context, EnterResultsPage.id);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const MyNavigationBar()
    );
  }
}
