import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChemicalProvider with ChangeNotifier {
  final List<String> _chemicals = [];

  List<String> get chemicals => _chemicals;

  Future<void> fetchChemicals() async {
    final snapshot = await FirebaseFirestore.instance.collection('chemicals').get();
    _chemicals.clear();
    for (var doc in snapshot.docs) {
      _chemicals.add(doc.data()['name'] as String);
    }
    notifyListeners();
  }

  Future<void> addChemical(String chemical) async {
    await FirebaseFirestore.instance.collection('chemicals').add({'name': chemical});
    _chemicals.add(chemical);
    notifyListeners();
  }
}

