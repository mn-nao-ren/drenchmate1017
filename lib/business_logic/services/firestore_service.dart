import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:drenchmate_2024/business_logic/models/property.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> savePropertyData(String userEmail, String propertyName, String location, String country, String countryCode, String postalCode, DateTime createdAt) async {
    await _firestore.collection('properties').add({
      'userEmail': userEmail,
      'propertyName': propertyName,
      'location': location,
      'country': country,
      'countryCode': countryCode,
      'postalCode': postalCode,
      'createdAt': createdAt,
    });
  }


  Future<void> saveMob(String propertyAddress, int paddockId, String mobName) async {
    final mobData = {
      'propertyAddress': propertyAddress,
      'paddockId': paddockId,
      'mobName': mobName,
      'createdAt': DateTime.now(),
    };

    try {
      await FirebaseFirestore.instance.collection('mobs').add(mobData);
      print('Mob data saved successfully: $mobData');
    } catch (e) {
      print('Failed to save mob data: $e');
      // Handle the error appropriately, e.g., show a message to the user
    }
  }

}