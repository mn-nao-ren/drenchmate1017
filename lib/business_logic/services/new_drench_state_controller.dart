// drench_entry_helpers.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> populateInitialData({
  required TextEditingController propertyIdController,
  required TextEditingController propertyAddressController,
  required TextEditingController dateController,
  required Function setState,
  required BuildContext context,
}) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String email = user.email!;
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('properties')
          .where('userEmail', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var propertyInfo = querySnapshot.docs.first.data() as Map<String, dynamic>;
        String propertyId = querySnapshot.docs.first.id;
        setState(() {
          propertyIdController.text = propertyId;
          propertyAddressController.text = propertyInfo['location'] ?? '';
          dateController.text = formatDate(DateTime.now());
        });
      }
    }
  } catch (e) {
    print('Error fetching user property info: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error fetching property info')),
    );
  }
}

String formatDate(DateTime date) {
  return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}

Future<void> selectDate({
  required BuildContext context,
  required TextEditingController dateController,
  required Function setState,
}) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );
  if (picked != null) {
    setState(() {
      dateController.text = formatDate(picked);
    });
  }
}

void handleSubmitted({
  required GlobalKey<FormState> formKey,
  required TextEditingController propertyIdController,
  required TextEditingController propertyAddressController,
  required TextEditingController dateController,
  required Function setState,
  required bool autovalidate,
  required BuildContext context,
}) {
  if (formKey.currentState!.validate()) {
    // Handle form submission, e.g., save data to database
    print('Form submitted: ${propertyIdController.text}, ${propertyAddressController.text}, ${dateController.text}');
  } else {
    // Show validation errors
    setState(() {
      autovalidate = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please fix the errors in red before submitting.')),
    );
  }
}
