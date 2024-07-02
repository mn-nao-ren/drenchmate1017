import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drenchmate_2024/business_logic/models/chemical_provider.dart';

class DrenchSummaryScreen extends StatelessWidget {
  final Map<String, String> drenchDetails;

  const DrenchSummaryScreen({super.key, required this.drenchDetails});

  @override
  Widget build(BuildContext context) {
    final chemicalProvider = Provider.of<ChemicalProvider>(context);
    final selectedChemical = chemicalProvider.chemicals.firstWhere(
      (chemical) => chemical['TradeName'] == drenchDetails['Chemical ID'],
      orElse: () => {},
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Drench Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Drench Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('Property ID: ${drenchDetails['Property ID']}'),
            Text('Drenching Date: ${drenchDetails['Drenching Date']}'),
            Text('Mob ID: ${drenchDetails['Mob ID']}'),
            Text('Chemical ID: ${drenchDetails['Chemical ID']}'),
            const SizedBox(height: 16),
            const Text(
              'Chemical Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('Trade Name: ${selectedChemical['TradeName'] ?? 'N/A'}'),
            Text('Batch Number: ${selectedChemical['BatchNumber'] ?? 'N/A'}'),
            Text('Expiration Date: ${selectedChemical['ExpirationDate'] ?? 'N/A'}'),
            Text('Dose Rate: ${selectedChemical['DoseRate'] ?? 'N/A'}'),
            Text('Withholding Period: ${selectedChemical['WithholdingPeriod'] ?? 'N/A'} days'),
            Text('Active Ingredient: ${selectedChemical['ActiveIngredient'] ?? 'N/A'}'),
          ],
        ),
      ),
    );
  }
}
