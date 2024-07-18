import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DrenchRecordList extends StatelessWidget {
  final String userId;
  final String? email;
  final Function(Map<String, dynamic> recordData, String email) onExport;

  const DrenchRecordList({super.key, required this.userId, required this.email, required this.onExport});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('users').doc(userId).collection('mobs').snapshots(),
        builder: (context, mobSnapshot) {
          if (mobSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!mobSnapshot.hasData || mobSnapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No mobs found'));
          }

          // Fetch drench records for each mob
          List<Widget> drenchRecordWidgets = [];
          for (var mobDoc in mobSnapshot.data!.docs) {
            drenchRecordWidgets.add(StreamBuilder<QuerySnapshot>(
              stream: mobDoc.reference.collection('drenches').snapshots(),
              builder: (context, drenchSnapshot) {
                if (drenchSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!drenchSnapshot.hasData || drenchSnapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No drench records found for mob ${mobDoc['mobNumber']}'));
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: drenchSnapshot.data!.docs.map((record) {
                    Map<String, dynamic> recordData = record.data() as Map<String, dynamic>;
                    recordData['mobName'] = mobDoc['mobName'];

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),

                      child: ListTile(
                        title: Text('Mob: ${mobDoc['mobName']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Mob Number: ${record['MobNumber']}'),
                            Text('Paddock Number: ${record['PaddockID']}'),
                            Text('Drench Date: ${record['DrenchingDate']}'),
                            Text('Comments: ${record['Comments']}'),
                          ],
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {
                            if (email != null && email!.isNotEmpty) {
                              onExport(recordData, email!);

                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please enter an email address')),
                              );
                            }
                          },
                          child: const Text('Export'),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ));
          }

          return ListView(
            children: drenchRecordWidgets,
          );
        },
      ),
    );
  }
}
