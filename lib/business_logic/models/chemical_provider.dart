import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChemicalProvider with ChangeNotifier {
  List<Map<String, dynamic>> _chemicals = [];

  List<Map<String, dynamic>> get chemicals => _chemicals;

  Future<void> fetchChemicals() async {
    final snapshot = await FirebaseFirestore.instance.collection('chemicals').get();
    _chemicals = snapshot.docs.map((doc) => doc.data()).toList();
    notifyListeners();
  }

  Future<void> addChemical(Map<String, dynamic> chemical) async {
    await FirebaseFirestore.instance.collection('chemicals').add(chemical);
    _chemicals.add(chemical);
    notifyListeners();
  }
}