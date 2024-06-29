// generate_report.dart
import 'dart:collection';
import 'package:flutter/material.dart';

class GenerateReportScreen extends StatefulWidget {
  static String id = 'generate_report_screen';

  @override
  _GenerateReportScreenState createState() => _GenerateReportScreenState();
}

class _GenerateReportScreenState extends State<GenerateReportScreen> {
  String? selectedProperty;
  String? selectedMob;
  //List<String> properties = [];
  //List<String> mobs = [];

  final List<String> properties = [
    'Property 1',
    'Property 2',
    'Property 3',
  ];

  final List<String> mobs = [
    'Mob 1',
    'Mob 2',
    'Mob 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedProperty,
              hint: const Text('Choose Property'),
              items: properties.map((String property) {
                return DropdownMenuItem<String>(
                  value: property,
                  child: Text(property),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedProperty = newValue;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Property',
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedMob,
              hint: const Text('Choose Mob'),
              items: mobs.map((String mob) {
                return DropdownMenuItem<String>(
                  value: mob,
                  child: Text(mob),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedMob = newValue;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Mob',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your logic to generate the report here
              },
              child: const Text('Generate Report'),
            ),
          ],
        ),
      ),
    );
  }
}