import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodayDateWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    String formattedDate = DateFormat('yMMMMd').format(today);

    return Text(
      '$formattedDate',
      style: TextStyle(fontSize: 14, color: Colors.grey.shade400)
    );
  }
}