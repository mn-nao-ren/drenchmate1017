import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:drenchmate_2024/business_logic/services/firestore_service.dart';
import 'push_notifications_service.dart';
import 'get_weather_service.dart';

class NoticeHandler with ChangeNotifier {
  final WeatherService _weatherService;
  // // could be push_notifications_service or the app's internal notifications page's service helper. KIV.
  // final NotificationService notificationService;
  List<String> notices = [];
  Timer? _timer;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirestoreService _firestoreService = FirestoreService();

  // measured in eggs per gram, a whole number integer
  static const int fecalEggThreshold = 200;
  // measured in days, factor this into homogenity of units when using this value
  static const int effectivePeriodDays = 5;

  NoticeHandler(this._firestoreService, this._weatherService) {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      checkConditions();
    });
  }

  @override
  void dispose() {
    // cancel the timer when the NoticeHandler is disposed
    _timer?.cancel();
    super.dispose();
  }

  void sendAdvancedNotice(String mobName) {
    String message =
        "Our system has detected conditions indicating that your previous drench for $mobName may no longer be effective. \n\nRecommended Actions:\n1. Immediate Drenching: Perform drenching using [recommended product].\n2. Review Drench Protocol: Consult with your veterinarian.\n3. Record Update: Ensure all details are logged in DrenchMate.\n4. Monitor Flock Health: Watch for health issues over the next few weeks.\n5. Regular Egg Counts: Schedule regular fecal egg count tests.\n6. Weather Monitoring: Stay alert to upcoming weather conditions.";
    notices.add(message);
    notifyListeners();

    // use push_notifications_service to send a push notification, show alert
    triggerNotification(message);
  }

  /* 
  final logic problem: checkCondtions method should be run on every mob, 
  all the advanced notices and push notifications are specific to each mob
  */
  void checkConditions() async {
    try {
      List<Map<String, dynamic>> mobs = await _firestoreService.fetchUserMobs();
      String userId = FirebaseAuth.instance.currentUser!.uid;

      for (Map<String, dynamic> mob in mobs) {
        String mobId = mob['id'];
        String mobName = mob['mobName'];

        int daysSinceLastDrench = await calculateDaysSinceLastDrench(mobId);

        var weatherConditions = await _weatherService.fetchWeatherConditions();

        int fecalEggCount = await _firestoreService.fetchFecalEggCount(userId, mobId);

        String reInfectionRisk =
            evaluateReInfectionRisk(weatherConditions, fecalEggCount);

        bool nextDrenchNeeded = determineNextDrenchNeeded(fecalEggCount);
        bool drenchEffective =
            checkDrenchEffective(daysSinceLastDrench, effectivePeriodDays);

        bool immediateDrenchingNeeded = evaluateImmediateDrenching(
          nextDrenchNeeded,
          drenchEffective,
          reInfectionRisk,
        );

        if (immediateDrenchingNeeded) {
          sendAdvancedNotice(mobName);
        }
      }
    } catch (e) {
      print("Error in checkConditions method, advanced_notice_logic file: $e");
    }
  }

  Future<int> calculateDaysSinceLastDrench(String mobId) async {
    int maxDaysSinceLastDrench = 0;
    String userId = FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot drenchesSnapshot =
        await _firestoreService.fetchLatestDrench(userId, mobId);

    if (drenchesSnapshot.docs.isNotEmpty) {
      Timestamp lastDrenchTimestamp = drenchesSnapshot.docs.first['date'];
      DateTime lastDrenchDate = lastDrenchTimestamp.toDate();

      DateTime today = DateTime.now();
      int daysSinceLastDrench = today.difference(lastDrenchDate).inDays;

      if (daysSinceLastDrench > maxDaysSinceLastDrench) {
        maxDaysSinceLastDrench = daysSinceLastDrench;
      }
    }

    return maxDaysSinceLastDrench;
  }

  String evaluateReInfectionRisk(var weatherConditions, int fecalEggCount) {
    // logic
    return ((weatherConditions == 'warm_humid') && (fecalEggCount > 0))
        ? 'high'
        : 'low';
  }

  bool determineNextDrenchNeeded(int fecalEggCount) {
    return (fecalEggCount > fecalEggThreshold);
  }

  bool checkDrenchEffective(int daysSinceLastDrench, int effectivePeriodDays) {
    return (daysSinceLastDrench <= effectivePeriodDays);
  }

  bool evaluateImmediateDrenching(
      bool nextDrenchNeeded, bool drenchEffective, String reInfectionRisk) {
    return (nextDrenchNeeded || !drenchEffective || reInfectionRisk == 'high');
  }
}
