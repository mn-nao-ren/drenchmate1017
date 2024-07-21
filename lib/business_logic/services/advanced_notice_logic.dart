import 'package:flutter/material.dart';
import 'dart:async';
import 'package:drenchmate_2024/business_logic/services/firestore_service.dart';
import 'get_weather_service.dart';
import 'push_notifications_service.dart';

class NoticeHandler with ChangeNotifier {
  // final WeatherService weatherService;
  // // could be push_notifications_service or the app's internal notifications page's service helper. KIV.
  // final NotificationService notificationService;
  List<String> notices = [];
  Timer? _timer;

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
  //   var weatherConditions =
  // }



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
