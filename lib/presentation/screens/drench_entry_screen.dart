import 'package:flutter/material.dart';
import 'chemical_entry_screen.dart'; // Import the Chemical Entry Screen

class DrenchEntryScreen extends StatefulWidget {
  static String id = 'Drench Entry';
  const DrenchEntryScreen({super.key});

  @override
  _DrenchEntryScreenState createState() => _DrenchEntryScreenState();
}

class _DrenchEntryScreenState extends State<DrenchEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _propertyIdController = TextEditingController(text: '12345'); // Pre-filled Property ID
  final TextEditingController _dateController = TextEditingController(); // Controller for the date field
  String _selectedMobId = 'Mob 1';
  String _selectedChemical = 'Chemical A';

  @override
  void initState() {
    super.initState();
    // Initialize the date controller with the current date
    _dateController.text = _formatDate(DateTime.now());
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dateController.text = _formatDate(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Drench Entry',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
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
                'Drench Entry',
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
                readOnly: true,
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
                readOnly: true,
                onTap: () => _selectDate(context),
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
                items: ['Chemical A', 'Chemical B', 'Chemical C'].map((chemical) {
                  return DropdownMenuItem<String>(
                    value: chemical,
                    child: Text(chemical),
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
                    MaterialPageRoute(builder: (context) => ChemicalEntryScreen()), // Navigate to ChemicalEntryScreen
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey, // Background color
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process data
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue, // Background color
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
