import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:drenchmate_2024/business_logic/models/chemical_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chemical_entry_screen.dart';
import 'package:drenchmate_2024/business_logic/services/new_drench_state_controller.dart';
import 'package:drenchmate_2024/presentation/screens/dashboard_view.dart';

class DrenchEntryScreen extends StatefulWidget {
  static String id = 'drench_entry_screen';
  const DrenchEntryScreen({super.key});

  @override
  _DrenchEntryScreenState createState() => _DrenchEntryScreenState();
}

class _DrenchEntryScreenState extends State<DrenchEntryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _propertyIdController = TextEditingController();
  final TextEditingController _propertyAddressController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  // final bool _autovalidate = false;

  String _selectedMobId = 'Mob 1';
  String? _selectedChemical;

  @override
  void initState() {
    super.initState();
    populateInitialData(
        propertyIdController: _propertyIdController,
        propertyAddressController: _propertyAddressController,
        dateController: _dateController,
        setState: setState,
        context: context
    );
  }

  Future<void> _saveDrenchDetails() async {
    if (_formKey.currentState!.validate()) {
      final drenchDetails = {
        'PropertyID': _propertyIdController.text,
        'PropertyAddress': _propertyAddressController.text, //
        'DrenchingDate': _dateController.text,
        'MobID': _selectedMobId,
        'ChemicalID': _selectedChemical ?? '',
      };

      await FirebaseFirestore.instance.collection('drench_records').add(drenchDetails);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Drench Entry Saved')),
      );
      Navigator.pushNamed(context, DashboardScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final chemicalProvider = Provider.of<ChemicalProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          children: [
            Text(
              '           Drench Entry',
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
                decoration: InputDecoration(
                  labelText: 'Property ID',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _propertyAddressController, // New TextFormField for Property Address
                decoration: InputDecoration(
                  labelText: 'Property Address',
                  prefixIcon: const Icon(Icons.location_on),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
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
                value: _selectedMobId,
                decoration: InputDecoration(
                  labelText: 'Choose Mob ID (Drop Down List)',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: ['Mob 1', 'Mob 2', 'Mob 3'].map((mob) {
                  return DropdownMenuItem<String>(
                    value: mob,
                    child: Text(mob),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedMobId = value!;
                  });
                },
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
                  });
                },
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
                onPressed: _saveDrenchDetails,
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