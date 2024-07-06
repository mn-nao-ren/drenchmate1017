import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drenchmate_2024/business_logic/services/firestore_service.dart';
import 'package:drenchmate_2024/business_logic/services/input_validation_service.dart';
import 'package:drenchmate_2024/business_logic/services/new_drench_state_controller.dart';


class SetupPropertyScreen extends StatefulWidget {
  static String id = 'setup_property_screen';

  const SetupPropertyScreen({super.key});

  @override
  _SetupPropertyScreenState createState() => _SetupPropertyScreenState();
}

class _SetupPropertyScreenState extends State<SetupPropertyScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirestoreService _firestoreService = FirestoreService();

  final TextEditingController _ownerEmailController = TextEditingController();
  final TextEditingController _propertyNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey.shade600,
          foregroundColor: Colors.white,
          title: Row(
            children: [
              Text(
                '           Set Up Property',
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Text('Property Details',
                      style: GoogleFonts.epilogue(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      )
                      //TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _ownerEmailController,
                    decoration: const InputDecoration(
                      labelText: 'Property Owner User Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _propertyNameController,
                    decoration: const InputDecoration(
                      labelText: 'Property Name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.landscape_rounded),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.add_location),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _countryController,
                    decoration: const InputDecoration(
                      labelText: 'Country',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.flag),
                    ),
                    validator: (value) => validateText(value, 'Country'),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _countryCodeController,
                    decoration: const InputDecoration(
                      labelText: 'Country Code',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.code),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _postalCodeController,
                    decoration: const InputDecoration(
                      labelText: 'Postal Code',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.mail),
                    ),
                    validator: (value) => validateText(value, 'Postal Code'),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          final String ownerEmail = _ownerEmailController.text.trim();
                          final String propertyName = _propertyNameController.text.trim();
                          final String address = _addressController.text.trim();
                          final String country = _countryController.text.trim();
                          final String countryCode = _countryCodeController.text.trim();
                          final String postalCode = _postalCodeController.text.trim();
                          final DateTime createdAt = DateTime.now();
              
                          await _firestoreService.savePropertyData(
                            ownerEmail, // Assuming owner email is used as a userId
                            propertyName,
                            address,
                            country,
                            countryCode,
                            postalCode,
                            createdAt,
                          );
              
                          // Show success message or navigate to another screen
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Property created successfully!')),
                          );
                          Navigator.of(context).pop();

                        } catch (e) {
                          // handle error
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 16),
                          backgroundColor: Colors.lightBlue,
                          foregroundColor: Colors.white,
                          elevation: 5.0),
                      child: const Text('Create', style: TextStyle(fontSize: 14)),
                    ),
                  ),
                ],
              ),
            )));
  }
}
