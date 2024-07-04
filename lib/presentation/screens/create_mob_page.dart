import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drenchmate_2024/business_logic/services/firestore_service.dart';
import 'package:drenchmate_2024/presentation/screens/dashboard_view.dart';

class CreateMobPage extends StatefulWidget {
  static String id = 'create_mob_page';

  const CreateMobPage({super.key});

  @override
  _CreateMobPageState createState() => _CreateMobPageState();
}

class _CreateMobPageState extends State<CreateMobPage> {
  final _formKey = GlobalKey<FormState>();
  String? propertyAddress;
  int? paddockId;
  String? mobName;

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
              '             Create a Mob',
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
        child: Form(
          key: _formKey,
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
                  prefixIcon: const Icon(Icons.home),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Property Address';
                  }
                  return null;
                },
                onSaved: (value) {
                  propertyAddress = value;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter Paddock Number',
                  prefixIcon: const Icon(Icons.landscape),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Paddock Number';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  paddockId = int.parse(value!);
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter Mob Name',
                  prefixIcon: const Icon(Icons.pets),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Mob Name';
                  }
                  return null;
                },
                onSaved: (value) {
                  mobName = value;
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      if (propertyAddress != null &&
                          paddockId != null &&
                          mobName != null) {
                        try {
                          await _firestoreService.saveMob(
                            propertyAddress!,
                            paddockId!,
                            mobName!,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Mob added successfully')),
                          );
                          Navigator.pushNamed(context, DashboardScreen.id);
                        } catch (e) {
                          print(e);
                        }
                      } else {
                        // Handle the case where values are not set
                        print('One or more values are null');
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    foregroundColor: Colors.white,
                    elevation: 5.0, // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text('Create Mob'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
