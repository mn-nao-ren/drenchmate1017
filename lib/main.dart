import 'package:drenchmate_2024/business_logic/services/firestore_service.dart';
import 'package:drenchmate_2024/presentation/screens/enter_egg_test_results.dart';
import 'package:drenchmate_2024/presentation/screens/generate_report_screen.dart';
import 'package:drenchmate_2024/presentation/screens/login_page.dart';
import 'package:drenchmate_2024/presentation/screens/notification_screen.dart';
import 'package:drenchmate_2024/presentation/screens/view_egg_results_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'business_logic/models/chemical_provider.dart';
import 'package:drenchmate_2024/presentation/screens/home_landing_page.dart';
import 'package:drenchmate_2024/presentation/screens/setup_property_screen.dart';
import 'package:drenchmate_2024/presentation/screens/email_registration_page.dart';
import 'package:drenchmate_2024/presentation/screens/dashboard_view.dart';
import 'package:drenchmate_2024/presentation/screens/create_profile.dart'; // class name CreateProfileScreen
import 'package:drenchmate_2024/presentation/screens/drench_entry_screen.dart';
import 'package:drenchmate_2024/presentation/screens/chemical_entry_screen.dart';
import 'package:drenchmate_2024/presentation/screens/create_mob_page.dart';
import 'package:drenchmate_2024/business_logic/state/navbar_state.dart';
import 'package:drenchmate_2024/business_logic/services/push_notifications_service.dart';
import 'package:drenchmate_2024/presentation/screens/mobs_view.dart';
import 'package:drenchmate_2024/business_logic/services/advanced_notice_logic.dart';
import 'package:drenchmate_2024/presentation/screens/drench_success_screen.dart';
import 'package:drenchmate_2024/presentation/screens/export_page.dart';
import 'package:drenchmate_2024/presentation/screens/save_results_success.dart';
import 'package:drenchmate_2024/presentation/screens/profile_page.dart';
import 'package:drenchmate_2024/presentation/screens/view_egg_results_page.dart';
import 'business_logic/services/get_weather_service.dart';
import 'package:drenchmate_2024/business_logic/services/firebase_api.dart';


final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  PushNotificationsService pushNotificationService = PushNotificationsService();

  // Initialize Flutter Local Notifications Plugin
  pushNotificationService.initializeNotifications();

  // check user status
  bool isFirstTime = prefs.getBool('is_first_time') ?? true;
  bool isRegistered = prefs.getBool('is_registered') ?? false;
  bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;

  runApp(DrenchMateApp(
    isFirstTime: isFirstTime,
    isRegistered: isRegistered,
    isLoggedIn: isLoggedIn,
  ));
}

class DrenchMateApp extends StatelessWidget {
  final bool isFirstTime;
  final bool isRegistered;
  final bool isLoggedIn;

  const DrenchMateApp({
    super.key,
    required this.isFirstTime,
    required this.isRegistered,
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    String initialRoute;

    if (isFirstTime) {
      initialRoute = HomePage.id; // First time user
    } else if (isLoggedIn) {
      initialRoute = DashboardScreen.id; // Logged in user
    } else if (isRegistered) {
      initialRoute = LoginScreen.id; // Registered but not logged in
    } else {
      initialRoute = HomePage.id; // Unregistered user
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavbarState()),
        ChangeNotifierProvider(create: (_) => NoticeHandler(FirestoreService(), WeatherService())),
        ChangeNotifierProvider(create: (_) => ChemicalProvider()..fetchChemicals()),
        Provider(create: (_) => FirestoreService()),
      ],
      child: MaterialApp(
        title: 'DrenchMate',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: initialRoute,
        routes: {
          HomePage.id: (context) => const HomePage(),
          RegistrationPage.id: (context) => const RegistrationPage(),
          LoginScreen.id: (context) => const LoginScreen(),
          DashboardScreen.id: (context) => const DashboardScreen(),
          CreateProfileScreen.id: (context) => const CreateProfileScreen(),
          GenerateReportScreen.id: (context) => const GenerateReportScreen(),
          SetupPropertyScreen.id: (context) => const SetupPropertyScreen(),
          DrenchEntryScreen.id: (context) => const DrenchEntryScreen(),
          ChemicalEntryScreen.id: (context) => const ChemicalEntryScreen(),
          CreateMobPage.id: (context) => const CreateMobPage(),
          NotificationScreen.id: (context) => const NotificationScreen(),
          EnterResultsPage.id: (context) => const EnterResultsPage(),
          MobsView.id: (context) => const MobsView(),
          DrenchSuccessPage.id: (context) => const DrenchSuccessPage(),
          ExportPage.id: (context) => const ExportPage(),
          ResultsSavedPage.id: (context) => const ResultsSavedPage(),
          ProfilePage.id: (context) => ProfilePage(),
          ViewEggResultsPage.id: (context) => ViewEggResultsPage(),
        },
      ),
    );
  }
}
