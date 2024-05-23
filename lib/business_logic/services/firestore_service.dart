import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drenchmate_2024/business_logic/models/user_model.dart';
import 'package:drenchmate_2024/business_logic/models/treatment_record.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add a new user
  Future<void> addUser(UserModel user) async {
    await _db.collection('users').doc(user.id).set(user.toMap());
  }

  // Get a user by ID
  Future<UserModel?> getUser(String id) async {
    var doc = await _db.collection('users').doc(id).get();
    return doc.exists ? UserModel.fromMap(doc.data()!) : null;
  }

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