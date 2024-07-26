import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drenchmate_2024/business_logic/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dashboard_view.dart';

class CreateMobPage extends StatefulWidget {
  static String id = 'create_mob_page';

  const CreateMobPage({super.key});

  @override
  _CreateMobPageState createState() => _CreateMobPageState();
}

class _CreateMobPageState extends State<CreateMobPage> {
  final TextEditingController _propertyAddressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? propertyAddress;
  int? paddockId;
  int? mobNumber;
  String? mobName;

  final FirestoreService _firestoreService = FirestoreService();

  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    _autoFillPropertyAddress();
  }

  Future<void> _autoFillPropertyAddress() async {
    String? propertyAddress = await _firestoreService.fetchUserPropertyAddress();
    if (propertyAddress != null) {
      setState(() {
        _propertyAddressController.text = propertyAddress;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue.shade900,
        automaticallyImplyLeading: false,
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
                controller: _propertyAddressController,
                decoration: InputDecoration(
                  labelText: 'Enter Property Address',
                  prefixIcon: const Icon(Icons.location_on_outlined),
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
                  labelText: 'Enter Paddock Number i.e. 1, 2, 3, etc',
                  prefixIcon: const Icon(Icons.cabin_outlined),
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
                  labelText: 'Assign Mob Number e.g. 1, 2, 3, etc',
                  prefixIcon: const Icon(Icons.numbers_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please assign a Mob number';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  mobNumber = int.parse(value!);
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
                          mobNumber != null &&
                          mobName != null &&
                          currentUser != null) {
                        try {
                          await _firestoreService.saveMob(
                            propertyAddress!,
                            paddockId!,
                            mobNumber!,
                            mobName!,
                            currentUser!.uid,
                            currentUser!.email!,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Mob added successfully')),
                          );
                          Navigator.pushNamed(context, DashboardScreen.id);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Mob not added, retry')),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('One or more values are null')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue.shade600,
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
