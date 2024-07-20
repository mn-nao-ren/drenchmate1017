import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class DrenchRecordList extends StatefulWidget {
  final String userId;
  final String? email;
  final Function(Map<String, dynamic> recordData, String email) onExport;

  const DrenchRecordList({
    super.key,
    required this.userId,
    required this.email,
    required this.onExport,
  });

  @override
  _DrenchRecordListState createState() => _DrenchRecordListState();
}

class _DrenchRecordListState extends State<DrenchRecordList> {
  List<Map<String, dynamic>> mobData = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    mobData = await fetchUserMobs();
    setState(() {});
  }

  Future<List<Map<String, dynamic>>> fetchUserMobs() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('User not logged in');
      return [];
    }

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('mobs')
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        data['mobNumber'] = data['mobNumber'].toString();
        return data;
      }).toList();
    } catch (e) {
      print('Error fetching mobs: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: mobData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: mobData.length,
        itemBuilder: (context, index) {
          final mob = mobData[index];
          return FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(widget.userId)
                .collection('mobs')
                .doc(mob['id'])
                .collection('drenches')
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text(
                      'No drench records found for mob ${mob['mobNumber']}'),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: snapshot.data!.docs.map((record) {
                  Map<String, dynamic> recordData =
                  record.data() as Map<String, dynamic>;
                  recordData['MobName'] = mob['mobName'];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      title: Text('Mob: ${mob['mobName']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Mob Number: ${recordData['MobName']}'),
                          Text('Paddock Number: ${recordData['PaddockID']}'),
                          Text('Drench Date: ${recordData['DrenchingDate']}'),
                          Text('Comments: ${recordData['Comments']}'),
                        ],
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          if (widget.email != null &&
                              widget.email!.isNotEmpty) {
                            widget.onExport(recordData, widget.email!);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                  Text('Please enter an email address')),
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
          );
        },
      ),
    );
  }
}