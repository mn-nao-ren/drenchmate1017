// generate_report.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drenchmate_2024/presentation/components/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class GenerateReportScreen extends StatefulWidget {
  static String id = 'generate_report_screen';

  const GenerateReportScreen({super.key});

  @override
  _GenerateReportScreenState createState() => _GenerateReportScreenState();
}

class _GenerateReportScreenState extends State<GenerateReportScreen> {
  String? selectedProperty;
  String? selectedMob;
  List<String> properties = [];
  List<String> mobs = [];

  @override
  void initState() {
    super.initState();
    fetchProperties();
    fetchMobs();
  }

  Future<void> fetchProperties() async {
    final QuerySnapshot result = await FirebaseFirestore.instance.collection('properties').get();
    final List<DocumentSnapshot> documents = result.docs;
    setState(() {
      properties = documents.map((doc) => doc['name'] as String).toList();
    });
  }

  Future<void> fetchMobs() async {
    final QuerySnapshot result = await FirebaseFirestore.instance.collection('mobs').get();
    final List<DocumentSnapshot> documents = result.docs;
    setState(() {
      mobs = documents.map((doc) => doc['name'] as String).toList();
    });
  }

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
      bottomNavigationBar: MyNavigationBar(),
    );
  }
}