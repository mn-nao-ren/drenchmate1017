import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:drenchmate_2024/business_logic/models/property.dart';



class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> savePropertyData(String userEmail, String propertyName, String location, DateTime createdAt) async {
    await _firestore.collection('properties').add({
      'userEmail': userEmail,
      'propertyName': propertyName,
      'location': location,
      'createdAt': createdAt,
    });
  }

}