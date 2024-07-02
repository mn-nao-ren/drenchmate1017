import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChemicalEntryScreen extends StatefulWidget {
  static String id = 'Chemical Entry';
  const ChemicalEntryScreen({super.key});

  @override
  _ChemicalEntryScreenState createState() => _ChemicalEntryScreenState();
}

class _ChemicalEntryScreenState extends State<ChemicalEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _chemicalNameController = TextEditingController();
  final TextEditingController _batchNoController = TextEditingController();
  final TextEditingController _withholdingPeriodController = TextEditingController(text: '5');
  String _selectedActiveIngredient = 'Zolvix';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Chemical Entry',
          style: GoogleFonts.openSans(
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
              Text(
                'Chemical Entry',
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _chemicalNameController,
                decoration: InputDecoration(
                  labelText: 'Chemical Name',
                  prefixIcon: const Icon(Icons.label),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the chemical name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedActiveIngredient,
                decoration: InputDecoration(
                  labelText: 'Active Ingredient',
                  prefixIcon: const Icon(Icons.format_list_bulleted),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: [
                  'Zolvix',
                  'Macrocycli Lactone (MLs)',
                  'Benzimidazole (BZ)',
                  'Levamisole (LV)',
                  'BZ + LV',
                  'Moxidectin',
                  'Closantel',
                ].map((ingredient) {
                  return DropdownMenuItem<String>(
                    value: ingredient,
                    child: Text(ingredient),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedActiveIngredient = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _batchNoController,
                decoration: InputDecoration(
                  labelText: 'Batch No.',
                  prefixIcon: const Icon(Icons.batch_prediction),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the batch number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: _withholdingPeriodController,
                      decoration: InputDecoration(
                        labelText: 'Withholding Period',
                        prefixIcon: const Icon(Icons.timelapse),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the withholding period';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('days', style: TextStyle(fontSize: 16)),
                ],
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
                ),
                child: Text(
                  'SUBMIT',
                  style: GoogleFonts.openSans(
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
