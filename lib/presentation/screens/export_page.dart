import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drenchmate_2024/presentation/components/bottom_navigation_bar.dart';
import 'package:excel/excel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:drenchmate_2024/presentation/screens/dashboard_view.dart';
import 'package:drenchmate_2024/presentation/components/username.dart';
import 'package:drenchmate_2024/business_logic/services/drench_record_list_svc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class ExportPage extends StatefulWidget {
  @override
  _ExportPageState createState() => _ExportPageState();
}

class _ExportPageState extends State<ExportPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _email;

  @override
  Widget build(BuildContext context) {
    String userId = _auth.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushNamed(context, DashboardScreen.id);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome back 👋',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const UserProfile(),

            const SizedBox(height: 20),

            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter the email address you want to export data to',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
            ),
            const SizedBox(height: 16),
            DrenchRecordList(
              userId: userId,
              email: _email,
              onExport: _exportDrenchRecord,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MyNavigationBar(),
    );
  }


  void _exportDrenchRecord(Map<String, dynamic> recordData, String email) async {

    // create Excel file
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['DrenchRecords'];

    // Add column headers
    sheetObject.appendRow([
      // all field names required by government
      // below is just example, fill it up correctly tmr
      const TextCellValue('Mob Name'),
      const TextCellValue('Mob Number'),
      const TextCellValue('Paddock ID'),
      const TextCellValue('Drenching Date'),
      const TextCellValue('Comments')
    ]);

    // Add drench record data
    sheetObject.appendRow([
      // the values of each field name required by government
      // below is just example, fill it up correctly tmr
      TextCellValue(recordData['mobName']),
      TextCellValue(recordData['MobNumber']),
      TextCellValue(recordData['PaddockID']),
      TextCellValue(recordData['DrenchingDate']),
      TextCellValue(recordData['Comments']),
    ]);

    // Save Excel file
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/drench_record.xlsx';
    final file = File(path);
    file.writeAsBytesSync(excel.encode()!);

    // Send email with attachment
    final Email emailToSend = Email(
      body: 'Please find the attached drench record.',
      subject: 'Drench Record Export',
      recipients: [email],
      attachmentPaths: [path],
      isHTML: false,
    );

    await FlutterEmailSender.send(emailToSend);


    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Drench record exported successfully')),
    );
  }

}