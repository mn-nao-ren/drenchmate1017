import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:drenchmate_2024/business_logic/models/mob.dart';

class MobProvider with ChangeNotifier {
  final List<Mob> _mobs = [];
  bool _isLoading = false;

  List<Mob> get mobs => _mobs;
  bool get isLoading => _isLoading;

  Future<void> fetchMobs() async {
    _isLoading = true;
    notifyListeners();

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('mobs').get();
      // _mobs = querySnapshot.docs.map((doc) => Mob.fromFirestore(doc)).toList();
    } catch (error) {
      print("Failed to fetch mobs: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
