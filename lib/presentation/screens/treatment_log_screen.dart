import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drenchmate_2024/business_logic/services/firestore_service.dart';
import 'package:drenchmate_2024/business_logic/models/treatment_record.dart';
import 'package:drenchmate_2024/presentation/screens/base_screen.dart';

class TreatmentLogScreen extends StatelessWidget {
  const TreatmentLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Treatment Log',
      body: FutureBuilder<List<TreatmentRecord>>(
        future: Provider.of<FirestoreService>(context).getTreatmentRecords(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No treatment records found.'));
          } else {
            var records = snapshot.data!;
            return ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                var record = records[index];
                return ListTile(
                  title: Text(record.productName),
                  subtitle: Text(
                    'Date: ${record.treatmentDate.toLocal()} | Animals: ${record.numberOfAnimals}',
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
