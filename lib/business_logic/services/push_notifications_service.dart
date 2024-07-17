import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Initialize the Flutter Local Notifications Plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void initializeNotifications() {
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

void triggerNotification(String message) {
  const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id', 'your_channel_name',
      importance: Importance.max, priority: Priority.high, ticker: 'ticker');
  const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
  flutterLocalNotificationsPlugin.show(0, 'DrenchMate Alert: Time to Drench Again!', message, platformChannelSpecifics);
}

void showAlertDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('DrenchMate Alert'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void checkConditionsAndNotify(BuildContext context, DateTime lastDrenchDate, int fecalEggCount, String weatherConditions, int effectivePeriodDays) {
  final daysSinceLastDrench = DateTime.now().difference(lastDrenchDate).inDays;

  // Check if the weather is warm and humid and there's a risk of re-infection
  final reInfectionRisk = ((weatherConditions == 'warm_humid') && (fecalEggCount > 0)) ? 'high' : 'low';

  // Threshold for fecal egg count
  const fecalEggThreshold = 200;

  // Determine if another drench is needed based on fecal egg count
  final nextDrenchNeeded = fecalEggCount > fecalEggThreshold;

  // Check if the last drench is still within its effective period
  final drenchEffective = (daysSinceLastDrench <= effectivePeriodDays);

  // Determine if immediate drenching is needed based on the above conditions
  if (nextDrenchNeeded || !drenchEffective || reInfectionRisk == 'high') {
    String message = "Our system has detected conditions indicating that your previous drench may no longer be effective. \n\nRecommended Actions:\n1. Immediate Drenching: Perform drenching using [recommended product].\n2. Review Drench Protocol: Consult with your veterinarian.\n3. Record Update: Ensure all details are logged in DrenchMate.\n4. Monitor Flock Health: Watch for health issues over the next few weeks.\n5. Regular Egg Counts: Schedule regular fecal egg count tests.\n6. Weather Monitoring: Stay alert to upcoming weather conditions.";

    // Trigger push notification
    triggerNotification(message);

    // Show in-app alert dialog
    showAlertDialog(context, message);
  }
}
