import 'package:flutter/material.dart';

class AdvancedNotice extends StatelessWidget {
  final String message;

  const AdvancedNotice({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          const Icon(
            Icons.notification_important,
            size: 50,
            color: Colors.red,
          ),
          const SizedBox(height: 10),
          Text(
            message,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
