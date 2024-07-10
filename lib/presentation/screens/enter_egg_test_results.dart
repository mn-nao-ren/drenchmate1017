import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drenchmate_2024/business_logic/services/firestore_service.dart';
import 'package:drenchmate_2024/presentation/screens/dashboard_view.dart';

class EnterResultsPage extends StatefulWidget {
  static String id = 'enter_results_page';

  const EnterResultsPage({super.key});

  @override
  _EnterResultsPageState createState() => _EnterResultsPageState();
}

class _EnterResultsPageState extends State<EnterResultsPage> {
  final FirestoreService _firestoreService = FirestoreService();
  User? currentUser = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();
  String? mobNumber;
  String? propertyAddress;
  int? paddockId;
  int? eggCountResults;

  List<String> mobList = [];
  List<String> fetchedMobs = [];
  String? selectedMob;

  Future<void> getMobs() async {
    if (currentUser != null) {
      try {
        fetchedMobs = await _firestoreService.fetchMobs(currentUser!.uid);
        print('Fetched mobs: $fetchedMobs');
        setState(() {
          mobList = fetchedMobs.toSet().toList(); // Ensure unique values
        });
        print('Mob List: $mobList');

      } catch (e) {
        // Handle error fetching mobs
        print('Error fetching mobs: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load mobs: $e')),
        );
      }
    }
  }


  @override
  void initState() {
    super.initState();
    getMobs();
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue.shade900,
        title: Row(
          children: [
            Text(
              '  Enter egg count test results',
              style: GoogleFonts.epilogue(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.science_outlined, size: 18),
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
                'Compulsory Test Details',
                  style: GoogleFonts.epilogue(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
              ),
              const SizedBox(height: 16),

              /* this one should be a drop down menu, fetch all mobs from
              * db and display in the menu */
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Select mob number',
                  prefixIcon: const Icon(Icons.numbers_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                value: selectedMob,
                items: mobList.map((mob) {
                  return DropdownMenuItem(
                    value: mob,
                      child: Text(mob),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a mob number';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    selectedMob = value;
                  });
                },
                onSaved: (value) {
                  mobNumber = value;
                },

              ),


              const SizedBox(height: 10),

              /* property address field still lacking auto pre-fill logic here */
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Enter property address',
                    prefixIcon: const Icon(Icons.cabin_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                ),
                keyboardType: TextInputType.text,
                validator:(value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a property address';
                  }
                  return null;
                },
                onSaved: (value) {
                  propertyAddress = value;
                },
              ),
              const SizedBox(height: 10),

              /* another drop down field of paddock numbers user has entered in
              * the system previously  */
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter paddock number',
                  prefixIcon: const Icon(Icons.numbers_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a paddock  number';
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
                  labelText: 'Enter egg count results in eggs per gram (epg)',
                  prefixIcon: const Icon(Icons.science_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter egg count results';
                  }
                  return null;
                },
                onSaved: (value) {
                  eggCountResults = int.parse(value!);
                },
              ),
              const SizedBox(height: 20,),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      if (mobNumber != null &&
                          propertyAddress != null &&
                          paddockId != null &&
                          eggCountResults != null) {
                        try {
                          // await _firestoreService.
                          // saveEggResults function

                        } catch (e) {
                          // close
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('One or more values are null')),
                        );
                      }
                    }
                  },
                  child: const Text('Save results'),
                )
              )

            ]
          )
        )
      )
    );
  }

}
