import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drenchmate_2024/business_logic/models/chemical_provider.dart';

class DrenchSummaryScreen extends StatelessWidget {
  static const String id = 'drench_summary_screen';
  final List<Map<String, dynamic>> drenchEntries;
  final int currentIndex;

  const DrenchSummaryScreen({
    super.key,
    required this.drenchEntries,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final chemicalProvider = Provider.of<ChemicalProvider>(context);
    final drenchDetails = drenchEntries[currentIndex];
    final selectedChemical = chemicalProvider.chemicals.firstWhere(
      (chemical) => chemical['TradeName'] == drenchDetails['ChemicalID'],
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
            Text('Property ID: ${drenchDetails['PropertyID']}'),
            Text('Drenching Date: ${drenchDetails['DrenchingDate']}'),
            Text('Mob ID: ${drenchDetails['MobID']}'),
            Text('Chemical ID: ${drenchDetails['ChemicalID']}'),
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
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                  onPressed: currentIndex > 0
                      ? () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DrenchSummaryScreen(
                                drenchEntries: drenchEntries,
                                currentIndex: currentIndex - 1,
                              ),
                            ),
                          );
                        }
                      : null,
                  child: const Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: currentIndex < drenchEntries.length - 1
                      ? () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DrenchSummaryScreen(
                                drenchEntries: drenchEntries,
                                currentIndex: currentIndex + 1,
                              ),
                            ),
                          );
                        }
                      : null,
                  child: const Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
