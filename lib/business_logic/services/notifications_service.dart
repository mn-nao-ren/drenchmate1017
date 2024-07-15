import 'package:flutter/material.dart';

class NotificationService {
  final DateTime lastDrenchDate;
  final String weatherConditions;
  final int fecalEggCount;
  final int effectivePeriodDays;

  NotificationService({
    required this.lastDrenchDate,
    required this.weatherConditions,
    required this.fecalEggCount,
    required this.effectivePeriodDays,
  });

  void showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('DrenchMate Alert'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void triggerNotification(String message) {
    // Implement your push notification logic here
    print("Push Notification: $message");
  }

  void checkConditionsAndNotify(BuildContext context) {
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
      String message = "Our system has detected conditions indicating that your "
          "previous drench may no longer be effective. "
          "\n\nRecommended Actions:"
          "\n1. Immediate Drenching: Perform drenching using "
          "[recommended product].\n"
          "2. Review Drench Protocol: "
          "Consult with your veterinarian.\n"
          "3. Record Update: Ensure all details are logged in DrenchMate.\n"
          "4. Monitor Flock Health: Watch for health issues over the next few weeks."
          "\n5. Regular Egg Counts: Schedule regular fecal egg count tests.\n"
          "6. Weather Monitoring: Stay alert to upcoming weather conditions.";

      // Trigger push notification
      triggerNotification(message);

      // Show in-app alert dialog
      showAlertDialog(context, message);
    }
  }
}
