import 'package:flutter/material.dart';

class AddTreatmentScreen extends StatelessWidget {
  const AddTreatmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Treatment'),
        backgroundColor: Colors.teal,
      ),
      body: const Center(
        child: Text('Add Treatment Screen'),
      ),
    );
  }
}