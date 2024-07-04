
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
  final _formKey = GlobalKey<FormState>();
  late String propertyAddress;
  late int paddockId;
  late String mobName;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade600,
        foregroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              '          Create a Mob',
              style: GoogleFonts.epilogue(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),

            ),
            const SizedBox(width: 8),
            const Icon(Icons.create_rounded, size: 18),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Text(
              'Mob Details',
              style: GoogleFonts.epilogue(
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),

            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Enter Property Address',
                prefixIcon: const Icon(Icons.forest_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              )
            ),
          ]
        )
      )
    );
  }


}
