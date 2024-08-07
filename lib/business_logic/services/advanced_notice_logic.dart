import 'dart:async';
import 'dart:convert'; // Import jsonDecode for handling message payloads
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // Import local notifications
// Import Firebase Messaging
import 'package:drenchmate_2024/business_logic/services/firestore_service.dart';
import 'firebase_api.dart';
import 'get_weather_service.dart';
import 'push_notifications_service.dart';


class NoticeHandler with ChangeNotifier {
  final WeatherService _weatherService;
  List<Map<String, dynamic>> notices = [];
  Map<String, DateTime> lastNotified = {};
  Timer? _timer;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirestoreService _firestoreService = FirestoreService();

  // measured in eggs per gram, a whole number integer
  static const int fecalEggThreshold = 200;
  // measured in days, factor this into homogenity of units when using this value
  static const int effectivePeriodDays = 5;
  static const Duration notificationInterval = Duration(hours: 24);

  final FirebaseApi _firebaseApi = FirebaseApi();

  NoticeHandler(this._firestoreService, this._weatherService) {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      checkConditions();
    });
  }

  @override
  void dispose() {
    // cancel the timer when the NoticeHandler is disposed
    _timer?.cancel();
    super.dispose();
  }

  void sendAdvancedNotice(String mobName, int paddockId, int mobNumber) {
    String timestamp = DateTime.now().toString();
    String message =
        "Our system has detected conditions indicating that your previous drench for $mobName may no longer be effective. \n\nRecommended Actions:\n1. Immediate Drenching: Perform drenching using [recommended product].\n2. Review Drench Protocol: Consult with your veterinarian.\n3. Record Update: Ensure all details are logged in DrenchMate.\n4. Monitor Flock Health: Watch for health issues over the next few weeks.\n5. Regular Egg Counts: Schedule regular fecal egg count tests.\n6. Weather Monitoring: Stay alert to upcoming weather conditions.";
    notices.add({
      'mobName': mobName,
      'paddockId': paddockId,
      'mobNumber': mobNumber,
      'timestamp': timestamp,
      'message': message,
      'acknowledged': false
    });
    notifyListeners();

    // Create a subtitle for the push notification
    String pushNotificationSubtitle = "Mob $mobNumber $mobName requires immediate drenching.";
    // Send push notification with specified title and subtitle
    _firebaseApi.initPushNotifications(); // Ensure notifications are initialized
    _firebaseApi.localNotifications.show(
      0,
      "DrenchMate Advanced Notice",
      pushNotificationSubtitle,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _firebaseApi.androidChannel.id,
          _firebaseApi.androidChannel.name,
          channelDescription: _firebaseApi.androidChannel.description,
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
      ),
      payload: jsonEncode({'title': "DrenchMate Advanced Notice", 'body': pushNotificationSubtitle}),
    );
  }


  // // with acknowledgement status
  // void checkConditions() async {
  //   try {
  //     List<Map<String, dynamic>> mobs = await _firestoreService.fetchUserMobs();
  //     String userId = FirebaseAuth.instance.currentUser!.uid;
  //
  //     for (Map<String, dynamic> mob in mobs) {
  //       String mobId = mob['id'];
  //       String mobName = mob['mobName'];
  //       int paddockId = int.parse(mob['paddockId'].toString()); // Convert to int
  //       int mobNumber = int.parse(mob['mobNumber'].toString()); // Convert to int
  //
  //       DocumentSnapshot mobDoc = await _firestore.collection('users')
  //           .doc(userId)
  //           .collection('mobs')
  //           .doc(mobId)
  //           .get();
  //
  //       var mobData = mobDoc.data() as Map<String, dynamic>?;
  //       if (mobData != null && mobData.containsKey('acknowledged') && mobData['acknowledged'] == true) {
  //         continue; // Skip this mob if it has been acknowledged
  //       }
  //
  //       int daysSinceLastDrench = await calculateDaysSinceLastDrench(mobId);
  //
  //       var weatherConditions = await _weatherService.fetchWeatherConditions();
  //
  //       int fecalEggCount = await _firestoreService.fetchFecalEggCount(userId, mobId);
  //
  //       String reInfectionRisk = evaluateReInfectionRisk(weatherConditions, fecalEggCount);
  //
  //       bool nextDrenchNeeded = determineNextDrenchNeeded(fecalEggCount);
  //       bool drenchEffective = checkDrenchEffective(daysSinceLastDrench, effectivePeriodDays);
  //
  //       bool immediateDrenchingNeeded = evaluateImmediateDrenching(
  //         nextDrenchNeeded,
  //         drenchEffective,
  //         reInfectionRisk,
  //       );
  //
  //       if (immediateDrenchingNeeded) {
  //         String noticeIdentifier = "$mobName-$paddockId-$mobNumber";
  //
  //         bool alreadyNotified = lastNotified.containsKey(noticeIdentifier) &&
  //             DateTime.now().difference(lastNotified[noticeIdentifier]!) < notificationInterval;
  //
  //         if (!alreadyNotified) {
  //           sendAdvancedNotice(mobName, paddockId, mobNumber);
  //           lastNotified[noticeIdentifier] = DateTime.now();
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     print("Error in checkConditions method, advanced_notice_logic file: $e");
  //   }
  // }



  //without acknowledgement status
  void checkConditions() async {
    try {
      List<Map<String, dynamic>> mobs = await _firestoreService.fetchUserMobs();
      String userId = FirebaseAuth.instance.currentUser!.uid;

      for (Map<String, dynamic> mob in mobs) {
        //print("mob data: $mob");

        String mobId = mob['id'];
        String mobName = mob['mobName'];
        int paddockId = int.parse(mob['paddockId'].toString()); // Convert to int
        int mobNumber = int.parse(mob['mobNumber'].toString()); // Convert to int

        int daysSinceLastDrench = await calculateDaysSinceLastDrench(mobId);

        var weatherConditions = await _weatherService.fetchWeatherConditions();

        int fecalEggCount = await _firestoreService.fetchFecalEggCount(userId, mobId);

        String reInfectionRisk = evaluateReInfectionRisk(weatherConditions, fecalEggCount);

        bool nextDrenchNeeded = determineNextDrenchNeeded(fecalEggCount);
        bool drenchEffective = checkDrenchEffective(daysSinceLastDrench, effectivePeriodDays);

        bool immediateDrenchingNeeded = evaluateImmediateDrenching(
          nextDrenchNeeded,
          drenchEffective,
          reInfectionRisk,
        );

        if (immediateDrenchingNeeded) {
          String noticeIdentifier = "$mobName-$paddockId-$mobNumber";


          // bool alreadyNotified = notices.any((notice) =>
          // notice['mobName'] == mobName &&
          //     notice['paddockId'] == paddockId &&
          //     notice['mobNumber'] == mobNumber &&
          //     notice['message'] == 'Drench Notice');

          bool alreadyNotified = lastNotified.containsKey(noticeIdentifier) &&
              DateTime.now().difference(lastNotified[noticeIdentifier]!) < notificationInterval;


          if (!alreadyNotified) {
            sendAdvancedNotice(mobName, paddockId, mobNumber);
            lastNotified[noticeIdentifier] = DateTime.now();
          }
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

  bool evaluateImmediateDrenching(bool nextDrenchNeeded, bool drenchEffective, String reInfectionRisk) {
    return (nextDrenchNeeded || !drenchEffective || reInfectionRisk == 'high');
  }

  void triggerNotification(String message) {
    PushNotificationsService().showNotification("Advanced Notice", message);
  }

  // without acknowledge
  void acknowledgeNotice(int index) {
    String noticeIdentifier = "${notices[index]['mobName']}-${notices[index]['paddockId']}-${notices[index]['mobNumber']}";
    lastNotified[noticeIdentifier] = DateTime.now();



    notices.removeAt(index); // Remove the notice from the list
    notifyListeners();
  }

  // // with acknowledge
  // void acknowledgeNotice(int index) async {
  //   String noticeIdentifier = "${notices[index]['mobName']}-${notices[index]['paddockId']}-${notices[index]['mobNumber']}";
  //   String mobId = notices[index]['mobId'];
  //
  //   lastNotified[noticeIdentifier] = DateTime.now();
  //
  //   // Save the acknowledgment status to Firestore
  //   await _firestore.collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection('mobs')
  //       .doc(mobId)
  //       .update({'acknowledged': true});
  //
  //   notices.removeAt(index); // Remove the notice from the list
  //   notifyListeners();
  // }

}
