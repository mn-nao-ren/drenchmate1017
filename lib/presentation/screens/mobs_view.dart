import 'package:drenchmate_2024/business_logic/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class MobsView extends StatefulWidget {
  static String id = 'mobs_view';

  const MobsView({super.key});

  @override
  _MobsViewState createState() => _MobsViewState();
}

class _MobsViewState extends State<MobsView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirestoreService _firestoreService = FirestoreService();
  List<Map<String, dynamic>> mobs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMobs();
  }

  Future<void> _loadMobs() async {
    try {
      final fetchedMobs = await _firestoreService.fetchUserMobs();
      setState(() {
        mobs = fetchedMobs;
        isLoading = false;
      });
    } catch (e) {
      print('Failed to load mobs: $e');
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue.shade900,
        title:  Row(
          children: [

            Text(
              '                All Mobs',
              style: GoogleFonts.epilogue(
                color: Colors.blue.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            const SizedBox(width: 6),
            const Icon(Icons.pets_outlined),

          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: mobs.length,
        itemBuilder: (context, index) {
          final mob = mobs[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(mob['mobName'] ?? 'No Name'),
              subtitle: Text('Paddock: ${mob['paddockId']} - Mob Number: ${mob['mobNumber']}'),
              onTap: () {
                // Handle mob tap, maybe navigate to a detailed page
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _loadMobs();
        },
        tooltip: 'Load Mobs',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
