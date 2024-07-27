import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ViewEggResultsPage extends StatefulWidget {
  static const String id = 'view_egg_results_page';

  @override
  _ViewEggResultsPageState createState() => _ViewEggResultsPageState();
}

class _ViewEggResultsPageState extends State<ViewEggResultsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  Future<List<Map<String, dynamic>>> fetchEggResults() async {
    try {
      CollectionReference mobsCollection =
      _firestore.collection('users').doc(userId).collection('mobs');
      QuerySnapshot mobSnapshot = await mobsCollection.get();

      List<Map<String, dynamic>> eggResults = [];

      for (QueryDocumentSnapshot mobDoc in mobSnapshot.docs) {
        QuerySnapshot eggResultsSnapshot = await mobDoc.reference
            .collection('eggResults')
            .orderBy('dateRecorded', descending: true)
            .limit(1)
            .get();

        if (eggResultsSnapshot.docs.isNotEmpty) {
          var eggResult = eggResultsSnapshot.docs.first.data() as Map<String, dynamic>?;

          eggResults.add({
            'mobName': mobDoc['mobName'] ?? 'Unknown Mob',
            'eggCount': eggResult?['eggCount'] ?? 0,
            'dateRecorded': (eggResult?['dateRecorded'] as Timestamp?)?.toDate() ?? DateTime.now(),
          });
        }
      }

      return eggResults;
    } catch (e) {
      print('Error fetching egg results: $e');
      throw Exception('Failed to fetch egg results: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '         View Egg Results',
          style: GoogleFonts.lato(

            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchEggResults(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No egg results found.'));
          } else {
            List<Map<String, dynamic>> eggResults = snapshot.data!;
            return ListView.builder(
              itemCount: eggResults.length,
              itemBuilder: (context, index) {
                var result = eggResults[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          result['mobName'],
                          style: GoogleFonts.epilogue(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Egg Count: ${result['eggCount']}',
                          style: GoogleFonts.epilogue(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Date: ${DateFormat('yyyy-MM-dd').format(result['dateRecorded'])}',
                          style: GoogleFonts.epilogue(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
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
