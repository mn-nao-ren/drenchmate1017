import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:drenchmate_2024/business_logic/models/treatment_record.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add a new user


  // Add a treatment record
  Future<void> addTreatmentRecord(TreatmentRecord record) async {
    await _db.collection('treatment_records').doc(record.id).set(record.toMap());
  }

  // Get all treatment records
  Future<List<TreatmentRecord>> getTreatmentRecords() async {
    var querySnapshot = await _db.collection('treatment_records').get();
    return querySnapshot.docs.map((doc) => TreatmentRecord.fromMap(doc.data())).toList();
  }
}