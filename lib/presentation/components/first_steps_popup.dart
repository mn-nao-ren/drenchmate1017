import 'package:flutter/material.dart';

class FirstStepsPopup extends StatelessWidget {
  const FirstStepsPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildStepCard(
            icon: Icons.house_outlined,
            text: 'Step 1: Property',
            margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 11.0),
          ),
          buildStepCard(
            icon: Icons.add_business,
            text: 'Step 2: Set up mobs',
            margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 11.0),
          ),
          buildStepCard(
            icon: Icons.house_outlined,
            text: 'Step 3: Paddock #',
            margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 11.0),
          ),
          buildStepCard(
            icon: Icons.medical_services_outlined,
            text: 'Step 4: Drench',
            margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 11.0),
          ),
          buildStepCard(
            icon: Icons.medical_information_outlined,
            text: 'Step 5: Egg Count',
            margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 11.0),
          ),
          buildStepCard(
            icon: Icons.notifications_outlined,
            text: 'Step 6: Notification',
            margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 11.0),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();

                },
                child: const Text('Close'),
              ),
          ),
        ],
      ),
    );
  }

  Widget buildStepCard({required IconData icon, required String text, required EdgeInsets margin}) {
    return Card(
      margin: margin,
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.teal,
        ),
        title: Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.teal.shade900,
            fontFamily: 'Source Sans Pro',
          ),
        ),
      ),
    );
  }
}