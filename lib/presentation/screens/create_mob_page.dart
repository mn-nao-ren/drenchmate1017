
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drenchmate_2024/business_logic/services/firestore_service.dart';

class CreateMobPage extends StatefulWidget {
  static String id = 'create_mob_page';

  const CreateMobPage({super.key});

  @override
  _CreateMobPageState createState() => _CreateMobPageState();
}

class _CreateMobPageState extends State<CreateMobPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }


}
