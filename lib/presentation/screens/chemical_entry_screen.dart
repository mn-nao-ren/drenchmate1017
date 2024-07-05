import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drenchmate_2024/business_logic/models/chemical_provider.dart';

class ChemicalEntryScreen extends StatefulWidget {
  static String id = 'chemical_entry_screen';
  const ChemicalEntryScreen({super.key});

  @override
  _ChemicalEntryScreenState createState() => _ChemicalEntryScreenState();
}

class _ChemicalEntryScreenState extends State<ChemicalEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tradeNameController = TextEditingController();
  final TextEditingController _batchNumberController = TextEditingController();
  final TextEditingController _expirationDateController = TextEditingController();
  final TextEditingController _doseRateController = TextEditingController();
  final TextEditingController _withholdingPeriodController = TextEditingController();
  String _selectedActiveIngredient = 'Zolvix';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _expirationDateController.text = '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final chemicalProvider = Provider.of<ChemicalProvider>(context);

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
              TextFormField(
                controller: _tradeNameController,
                decoration: InputDecoration(
                  labelText: 'Trade Name',
                  prefixIcon: const Icon(Icons.label),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the trade name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _batchNumberController,
                decoration: InputDecoration(
                  labelText: 'Batch Number',
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
              TextFormField(
                controller: _expirationDateController,
                decoration: InputDecoration(
                  labelText: 'Expiration Date',
                  prefixIcon: const Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _doseRateController,
                decoration: InputDecoration(
                  labelText: 'Dose Rate',
                  prefixIcon: const Icon(Icons.medical_services),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the dose rate';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _withholdingPeriodController,
                decoration: InputDecoration(
                  labelText: 'Withholding Period (days)',
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
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedActiveIngredient,
                decoration: InputDecoration(
                  labelText: 'Active Ingredient',
                  prefixIcon: const Icon(Icons.category),
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
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final chemical = {
                      'TradeName': _tradeNameController.text,
                      'BatchNumber': _batchNumberController.text,
                      'ExpirationDate': _expirationDateController.text,
                      'DoseRate': double.parse(_doseRateController.text),
                      'WithholdingPeriod': int.parse(_withholdingPeriodController.text),
                      'ActiveIngredient': _selectedActiveIngredient,
                    };
                    chemicalProvider.addChemical(chemical);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Chemical Added')),
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
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