import 'package:firebase_auth/firebase_auth.dart';
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
  List<Map<String, dynamic>> mobs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMyMobs();
  }

  Future<void> fetchMyMobs() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Handle the case where the user is not logged in
      print('User not logged in');
      return;
    }

    try {
      QuerySnapshot snapshot = await _firestore
          .collection('mobs')
          .where('userId', isEqualTo: user.uid)
          .get();
      setState(() {
        mobs = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching mobs: $e');
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
        onPressed: fetchMyMobs,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
