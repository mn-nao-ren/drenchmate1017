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

  Future<void> _updatePaddockId(String userId, String mobNumber, int newPaddockId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('mobs')
          .doc(mobNumber)
          .update({'paddockId': newPaddockId});
      print('Paddock ID updated successfully');
    } catch (e) {
      print('Failed to update paddock ID: $e');
    }
  }

  void _showChangePaddockDialog(String userId, String mobNumber) {
    final TextEditingController _paddockIdController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Paddock ID'),
          content: TextField(
            controller: _paddockIdController,
            decoration: const InputDecoration(hintText: 'Enter new paddock ID'),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (_paddockIdController.text.isNotEmpty) {
                  final int newPaddockId = int.parse(_paddockIdController.text);
                  await _updatePaddockId(userId, mobNumber, newPaddockId);
                  Navigator.of(context).pop();
                  _loadMobs(); // Refresh the mobs list
                }
              },
              child: const Text('Change'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue.shade900,
        title: Row(
          children: [
            Text(
              'All Mobs (tap mob to change paddock number)',
              style: GoogleFonts.epilogue(
                color: Colors.blue.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 5),
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
          final mobName = mob['mobName'] ?? 'No Name';
          final paddockId = mob['paddockId']?.toString() ?? 'No Paddock';
          final mobNumber = mob['mobNumber']?.toString() ?? 'No Mob Number';
          final userId = mob['userId'] ?? '';

          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(mobName),
              subtitle: Text('Paddock: $paddockId - Mob Number: $mobNumber'),
              onTap: () {
                if (userId.isNotEmpty && mobNumber.isNotEmpty) {
                  _showChangePaddockDialog(userId, mobNumber);
                } else {
                  // Handle the case where userId or mobNumber is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invalid userId or mobNumber')),
                  );
                }
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
