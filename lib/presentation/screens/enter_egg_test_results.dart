import 'package:drenchmate_2024/presentation/components/bottom_navigation_bar.dart';
import 'package:drenchmate_2024/presentation/screens/save_results_success.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drenchmate_2024/business_logic/services/firestore_service.dart';
import 'package:drenchmate_2024/presentation/screens/dashboard_view.dart';
import 'package:drenchmate_2024/presentation/screens/save_results_success.dart';

class EnterResultsPage extends StatefulWidget {
  static String id = 'enter_results_page';

  const EnterResultsPage({super.key});

  @override
  _EnterResultsPageState createState() => _EnterResultsPageState();
}

class _EnterResultsPageState extends State<EnterResultsPage> {
  List<Map<String, dynamic>> mobs = [];
  bool isLoading = true;
  List<String> mobNumbers = [];

  Map<String, String> mobNumberToIdMap = {};

  String? _selectedMobNumber;

  final FirestoreService _firestoreService = FirestoreService();
  User? currentUser = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();
  String? mobNumber;
  DateTime? testDate;
  int? eggCountResults;



  Future<void> _loadMobs() async {
    try {
      final fetchedMobs = await _firestoreService.fetchUserMobs();

      setState(() {
        mobs = fetchedMobs;
        isLoading = false;

        // populate mobNumbers list and mobNumberToIdMap
        mobNumbers = fetchedMobs.map((mob) => mob['mobNumber'].toString()).toList();
        mobNumberToIdMap = {for (var mob in fetchedMobs) mob['mobNumber'].toString(): mob['id']};

        // if there are no mobs for the user, _selectedMobNumber is cleared
        if (_selectedMobNumber != null && !mobNumbers.contains(_selectedMobNumber)) {
          _selectedMobNumber = null;
        }
      });
    } catch (e) {
      print('Failed to load mobs: $e');
      setState(() {
        isLoading = false;
      });

    }
  }

  @override
  void initState() {
    super.initState();
    _loadMobs();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue.shade900,
          title: Row(
            children: [
              Text(
                '             Enter egg count test results',
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
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 16),

                      /* this one should be a drop down menu, fetch all mobs from
              * db and display in the menu */
                      DropdownButtonFormField<String>(
                        value: _selectedMobNumber,
                        decoration: InputDecoration(
                          labelText: 'Choose Mob Number',
                          prefixIcon: const Icon(Icons.group),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        items: mobNumbers.map((mob) {
                          return DropdownMenuItem<String>(
                            value: mob,
                            child: Text(mob),
                          );
                        }).toList(),
                        onChanged: (value) async {
                          setState(() {
                            _selectedMobNumber = value!;
                          });

                        },

                        onSaved: (value) {
                          mobNumber = value;
                        },
                      ),
                      const SizedBox(height: 15),


                      TextFormField(
                        decoration: InputDecoration(
                          labelText:
                              'Enter egg count results in eggs per gram (epg)',
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

                      const SizedBox( height: 15),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              try {
                                await _firestoreService.saveEggResults(
                                    mobNumber!,
                                    eggCountResults!,
                                );

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Results saved successfully'),
                                  ),
                                );

                                Navigator.pushNamed(context, DashboardScreen.id);
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Failed to save egg results: $e'),
                                  )
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

        ),

    );
  }
}
