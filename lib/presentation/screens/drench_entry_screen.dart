import 'package:flutter/material.dart'; //managed to get mob number to load. paddockId working
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:drenchmate_2024/business_logic/models/chemical_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drenchmate_2024/business_logic/services/firestore_service.dart';
import '../../business_logic/models/profile.dart';
import '../components/bottom_navigation_bar.dart';
import 'chemical_entry_screen.dart';
import 'package:drenchmate_2024/business_logic/services/new_drench_state_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:drenchmate_2024/presentation/screens/drench_success_screen.dart';

import 'dashboard_view.dart';

class DrenchEntryScreen extends StatefulWidget {
  static String id = 'drench_entry_screen';
  const DrenchEntryScreen({super.key});

  @override
  _DrenchEntryScreenState createState() => _DrenchEntryScreenState();
}

class _DrenchEntryScreenState extends State<DrenchEntryScreen> {

  final FirestoreService _firestoreService = FirestoreService();
  List<Map<String, dynamic>> mobs = [];
  bool isLoading = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _propertyIdController = TextEditingController();
  final TextEditingController _propertyAddressController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _livestockQtyController = TextEditingController();
  final TextEditingController _withholdingPeriodController = TextEditingController();
  final TextEditingController _exportSlaughterIntervalController = TextEditingController();
  final TextEditingController _dateSafeForSlaughterController = TextEditingController();
  final TextEditingController _adverseReactionsController = TextEditingController();
  final TextEditingController _equipmentCleanedByController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  final TextEditingController _batchNumberController = TextEditingController();
  final TextEditingController _expirationDateController = TextEditingController();
  final TextEditingController _doseRateController = TextEditingController();
  final TextEditingController _paddockIdController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();

  String? _selectedMobNumber;
  String? _selectedChemical;
  String _brokenNeedleInAnimal = 'No';
  String _equipmentCleaned = 'Yes';

  User? currentUser;

  Map<String, String> mobNumberToIdMap = {};
  List<String> mobNumbers = [];

  @override
  void initState() {
    super.initState();
    populateInitialData(
      propertyIdController: _propertyIdController,
      propertyAddressController: _propertyAddressController,
      dateController: _dateController,
      setState: setState,
      context: context,
    );
    fetchCurrentUserDetails();
    _loadMobs();
  }

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

  Future<void> fetchCurrentUserDetails() async {
    try {
      currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        String uid = currentUser!.uid;
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
        setState(() {
          _equipmentCleanedByController.text = userDoc['username'];
          _contactNoController.text = userDoc['contactNumber'];
        });
      } else {
        setState(() {
          _equipmentCleanedByController.text = 'N/A';
          _contactNoController.text = 'N/A';
        });
      }
    } catch (e) {
      print(e);
      print('Error happens in drench entry screen fetchCurrentUserDetails method');
      setState(() {
        _equipmentCleanedByController.text = 'Error loading data';
        _contactNoController.text = 'Error loading data';
      });
    }
  }


  Future<void> fetchPaddockId(String userId, String mobNumber) async {
    try {
      String? mobId = mobNumberToIdMap[mobNumber];
      if (mobId != null) {
        DocumentSnapshot mobDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('mobs')
            .doc(mobId)
            .get();

        setState(() {
          _paddockIdController.text = mobDoc.get('paddockId').toString();
        });

      } else {
        throw Exception('Mob ID not found for the selected Mob Number');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load paddock ID: $e')),
      );
    }
  }

  Future<void> _saveDrenchDetails(String mobId, String userName) async {
    if (_formKey.currentState!.validate()) {
      final drenchDetails = {
        'PropertyID': _propertyIdController.text,  // String
        'PropertyAddress': _propertyAddressController.text,  // String
        'LivestockDescription': 'Sheep',  // String
        'PaddockID': _paddockIdController.text,  // String
        'LivestockQty': int.tryParse(_livestockQtyController.text) ?? 0,  // Integer conversion with default value
        'DrenchingDate': _dateController.text,  // String
        'MobNumber': int.tryParse(_selectedMobNumber.toString()) ?? 0,  // Ensure this is an int
        'ChemicalID': _selectedChemical ?? '',  // String
        'BatchNumber': _batchNumberController.text,  // String
        'ExpirationDate': _expirationDateController.text,  // String
        'DoseRate': _doseRateController.text,  // String
        'WithholdingPeriod': _withholdingPeriodController.text,  // String
        'ExportSlaughterInterval': _exportSlaughterIntervalController.text,  // String
        'DateSafeForSlaughter': _dateSafeForSlaughterController.text,  // String
        'AdverseReactions': _adverseReactionsController.text,  // String
        'BrokenNeedleInAnimal': _brokenNeedleInAnimal,  // Boolean
        'EquipmentCleaned': _equipmentCleaned,  // Boolean
        'EquipmentCleanedBy': _equipmentCleanedByController.text,  // String
        'ContactNo': _contactNoController.text,  // String
        'Comments': _commentsController.text,  // String
        'PerformedBy': userName,  // Include the user name
      };

      try {
        // Assuming you have the user ID available in your app
        String userId = FirebaseAuth.instance.currentUser!.uid;
        int selectedMobNumberInt = int.tryParse(_selectedMobNumber.toString()) ?? 0;  // Convert to int safely

        // Fetch the correct mob document based on the userId and mob number
        QuerySnapshot mobSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('mobs')
            .where('mobNumber', isEqualTo: selectedMobNumberInt)  // Ensure this is an int
            .get();

        if (mobSnapshot.docs.isNotEmpty) {
          DocumentReference mobDocRef = mobSnapshot.docs.first.reference;
          CollectionReference drenchesCollection = mobDocRef.collection('drenches');
          await drenchesCollection.add(drenchDetails);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Drench Entry Saved')),
          );
          Navigator.pushNamed(context, DrenchSuccessPage.id);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No matching mob found')),
          );
        }
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save drench details: $e')),
        );
      }
    }
  }






  Future<void> calculateDateSafeForSlaughter() async {
    if (_dateController.text.isNotEmpty && _withholdingPeriodController.text.isNotEmpty) {
      DateTime drenchingDate = DateTime.parse(_dateController.text);
      int withholdingPeriod = int.parse(_withholdingPeriodController.text);
      DateTime dateSafeForSlaughter = drenchingDate.add(Duration(days: withholdingPeriod));

      setState(() {
        _dateSafeForSlaughterController.text = dateSafeForSlaughter.toString().split(' ')[0];
      });
    }
  }

  InputDecoration _readOnlyInputDecoration(String labelText, IconData icon) {
    return InputDecoration(
      labelText: labelText,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      fillColor: Colors.grey[200],
      filled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final chemicalProvider = Provider.of<ChemicalProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,

        title: Row(
          children: [
            Text(
              '                     Drench Entry',
              style: GoogleFonts.epilogue(
                color: Colors.blue.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.edit,
              color: Colors.blue.shade900,
              size: 20,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 16),
              const Text(
                'Drench Form',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _propertyIdController,
                decoration: _readOnlyInputDecoration('Property ID', Icons.person),

              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _propertyAddressController,
                decoration: _readOnlyInputDecoration('Property Address', Icons.location_on),

              ),
              const SizedBox(height: 16),
              const Text('Livestock description: describe livestock and location'),
              const SizedBox(height: 8),
              TextFormField(
                decoration: _readOnlyInputDecoration('Livestock Description', Icons.description),

                controller: TextEditingController(text: 'Sheep'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _livestockQtyController,
                decoration: InputDecoration(
                  labelText: 'Livestock Qty',
                  prefixIcon: const Icon(Icons.format_list_numbered),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Drenching Date',
                  prefixIcon: const Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onTap: () => selectDate(
                  context: context,
                  dateController: _dateController,
                  setState: setState,
                ),
              ),
              const SizedBox(height: 16),
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

                  // fetch the paddock id based on selected mob number
                  User? user = FirebaseAuth.instance.currentUser;
                  String? userId;
                  if (user != null) {
                    userId = user.uid;
                  } else {
                    print('User is not logged in.');
                  }

                  await fetchPaddockId(userId!, value!);
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _paddockIdController,
                decoration: _readOnlyInputDecoration('Paddock ID', Icons.landscape),

              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedChemical,
                decoration: InputDecoration(
                  labelText: 'Choose Chemical ID (DropDL)',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: chemicalProvider.chemicals.map((chemical) {
                  return DropdownMenuItem<String>(
                    value: chemical['TradeName'],
                    child: Text(chemical['TradeName']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedChemical = value!;
                    final selectedChemical = chemicalProvider.chemicals.firstWhere(
                          (chemical) => chemical['TradeName'] == value,
                    );
                    _batchNumberController.text = selectedChemical['BatchNumber'];
                    _expirationDateController.text = selectedChemical['ExpirationDate'];
                    _doseRateController.text = selectedChemical['DoseRate'].toString();
                    _withholdingPeriodController.text = selectedChemical['WithholdingPeriod'].toString();

                    // Set Export Slaughter Interval to be the same as Withholding Period
                    _exportSlaughterIntervalController.text = selectedChemical['WithholdingPeriod'].toString();

                    // Calculate Date Safe for Slaughter
                    calculateDateSafeForSlaughter();
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _batchNumberController,
                decoration: _readOnlyInputDecoration('Batch Number', Icons.format_list_numbered),

              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _expirationDateController,
                decoration: _readOnlyInputDecoration('Expiration Date', Icons.date_range),

              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _doseRateController,
                decoration: _readOnlyInputDecoration('Dose Rate', Icons.speed),

              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _withholdingPeriodController,
                decoration: _readOnlyInputDecoration('Withholding Period', Icons.timer),

              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _exportSlaughterIntervalController,
                decoration: _readOnlyInputDecoration('Export Slaughter Interval', Icons.local_shipping),

              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dateSafeForSlaughterController,
                decoration: _readOnlyInputDecoration('Date Safe for Slaughter', Icons.event_available),

              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _adverseReactionsController,
                decoration: InputDecoration(
                  labelText: 'Adverse Reactions',
                  prefixIcon: const Icon(Icons.warning),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _brokenNeedleInAnimal,
                decoration: InputDecoration(
                  labelText: 'Broken Needle in Animal',
                  prefixIcon: const Icon(Icons.healing),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: ['Yes', 'No'].map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _brokenNeedleInAnimal = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _equipmentCleaned,
                decoration: InputDecoration(
                  labelText: 'Equipment Cleaned/Calibrated',
                  prefixIcon: const Icon(Icons.cleaning_services),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: ['Yes', 'No'].map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _equipmentCleaned = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _equipmentCleanedByController,
                decoration: _readOnlyInputDecoration('Equipment Cleaned/Calibrated By', Icons.person),

              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contactNoController,
                decoration: _readOnlyInputDecoration('Contact No', Icons.phone),

              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _commentsController,
                decoration: _readOnlyInputDecoration('Comments', Icons.comment),
              ),

              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChemicalEntryScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Manage Chemicals Here',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // Assuming you have the user ID available in your app
                    String userId = FirebaseAuth.instance.currentUser!.uid;

                    // Fetch the user profile
                    Profile userProfile = await FirestoreService().fetchUserProfile(userId);

                    // Fetch the mobId (you may need to adjust this based on how you obtain the mobId)
                    String mobId = _selectedMobNumber.toString(); // Adjust as needed

                    // Call _saveDrenchDetails with mobId and userName
                    await _saveDrenchDetails(mobId, userProfile.username);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Saved drench details!')),
                    );
                    Navigator.pushNamed(context, DashboardScreen.id);

                  } catch (e) {
                    print(e);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to save drench details: $e')),
                    );
                  }
                },
                //onPressed: _saveDrenchDetails,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'ADD',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}

