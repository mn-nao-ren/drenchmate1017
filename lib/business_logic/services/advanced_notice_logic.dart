import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:drenchmate_2024/business_logic/services/firestore_service.dart';

class NoticeHandler with ChangeNotifier {
  // final WeatherService weatherService;
  // // could be push_notifications_service or the app's internal notifications page's service helper. KIV.
  // final NotificationService notificationService;
  List<String> notices = [];
  Timer? _timer;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirestoreService _firestoreService = FirestoreService();

  // NoticeHandler(this.weatherService, this.notificationService);

  @override
  void dispose() {
    // cancel the timer when the NoticeHandler is disposed
    _timer?.cancel();
    super.dispose();
  }

  NoticeHandler() {
    // Initialize and start the timer
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      //checkConditions();
    });
  }

  // void checkConditions() {
  //   int daysSinceLastDrench = calculateDaysSinceLastDrench();
  //   var weatherConditions = weatherService.getWeatherConditions();
  //   double reInfectionRisk = evaluateReInfectionRisk(weatherConditions, fecalEggCount);
  //
  //   const fecalEggThreshold = 200;
  //   bool nextDrenchNeeded = determineNextDrenchNeeded(fecalEggCount);
  //   bool drenchEffective = checkDrenchEffective(daysSinceLastDrench, effectivePeriodDays);
  //
  //   bool immediateDrenchingNeeded = evaluateImmediateDrenching(
  //       nextDrenchNeeded,
  //       drenchEffective,
  //       reInfectionRisk
  //   );
  //
  //   if (immediateDrenchingNeeded) {
  //     notificationService.sendAdvancedNotice();
  //   }
  // }

  Future<int> calculateDaysSinceLastDrench() async {
    List<Map<String, dynamic>> mobs = await _firestoreService.fetchUserMobs();
    int daysSinceLastDrench = 0;
    String userId = FirebaseAuth.instance.currentUser!.uid;

    for (Map<String, dynamic> mob in mobs) {
      String mobId = mob['id'];

      //Access the drench documents using fs service
      QuerySnapshot drenchesSnapshot = await _firestoreService
          .fetchLatestDrench(userId, mobId);

      if (drenchesSnapshot.docs.isNotEmpty) {
        // Assuming 'date' is stored as a Timestamp in Firestore
        Timestamp lastDrenchTimestamp = drenchesSnapshot.docs.first['date'];
        DateTime lastDrenchDate = lastDrenchTimestamp.toDate();

        // Calculate days since last drench
        DateTime today = DateTime.now();
        daysSinceLastDrench = today
            .difference(lastDrenchDate)
            .inDays;
      }
    }

    // Return the calculated value
    return daysSinceLastDrench;
  }





  Future<bool> evaluateConditions() async {
    FirestoreService firestoreService = FirestoreService();
    List<Map<String, dynamic>> mobs = [];
    /* load mobs
    *
    * get the latest drench record from the mobs collection,
    * get the date and calculate difference between current day's date and
    *   this last drench date.
    * */

    try {
      mobs = await firestoreService.fetchUserMobs();
      //print('Mobs for current user (advanced notice feature) : $mobs');
    } catch (e) {
      print('Error fetching mobs: $e');
    }

    /*
    *
    * get the weather conditions. check if it's warm_humid
    * get the most recent egg count result for the mob and check if it's more than zero or not
    *     if weather is warm_humid and egg count > 0, set reInfectionRisk to 'high', else 'low'
    *
    *
    *
    * */
    return true;
  }

  void sendAdvancedNotice(String message) {
    notices.add(message);
    notifyListeners();
  }

  // Future<void> checkConditions() async {
  //   bool conditionsMet = await evaluateConditions();
  //   String message = "Our system has detected conditions indicating that your previous drench may no longer be effective. \n\nRecommended Actions:\n1. Immediate Drenching: Perform drenching using [recommended product].\n2. Review Drench Protocol: Consult with your veterinarian.\n3. Record Update: Ensure all details are logged in DrenchMate.\n4. Monitor Flock Health: Watch for health issues over the next few weeks.\n5. Regular Egg Counts: Schedule regular fecal egg count tests.\n6. Weather Monitoring: Stay alert to upcoming weather conditions.";
  //
  //
  //   if (conditionsMet) {
  //     sendAdvancedNotice(message);
  //   }
  // }
}
