import 'package:cloud_firestore/cloud_firestore.dart';

class TreatmentRecord {
  String id;
  DateTime treatmentDate;
  int numberOfAnimals;
  String mobId;
  String classOfAnimal;
  String productName;
  String activeIngredient;
  double treatmentRate;
  String esi;
  String wp;
  String batchNumber;
  DateTime expiryDate;
  String personName;

  TreatmentRecord({
    required this.id,
    required this.treatmentDate,
    required this.numberOfAnimals,
    required this.mobId,
    required this.classOfAnimal,
    required this.productName,
    required this.activeIngredient,
    required this.treatmentRate,
    required this.esi,
    required this.wp,
    required this.batchNumber,
    required this.expiryDate,
    required this.personName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'treatmentDate': treatmentDate,
      'numberOfAnimals': numberOfAnimals,
      'mobId': mobId,
      'classOfAnimal': classOfAnimal,
      'productName': productName,
      'activeIngredient': activeIngredient,
      'treatmentRate': treatmentRate,
      'esi': esi,
      'wp': wp,
      'batchNumber': batchNumber,
      'expiryDate': expiryDate,
      'personName': personName,
    };
  }

  factory TreatmentRecord.fromMap(Map<String, dynamic> map) {
    return TreatmentRecord(
      id: map['id'],
      treatmentDate: (map['treatmentDate'] as Timestamp).toDate(),
      numberOfAnimals: map['numberOfAnimals'],
      mobId: map['mobId'],
      classOfAnimal: map['classOfAnimal'],
      productName: map['productName'],
      activeIngredient: map['activeIngredient'],
      treatmentRate: map['treatmentRate'],
      esi: map['esi'],
      wp: map['wp'],
      batchNumber: map['batchNumber'],
      expiryDate: (map['expiryDate'] as Timestamp).toDate(),
      personName: map['personName'],
    );
  }
}