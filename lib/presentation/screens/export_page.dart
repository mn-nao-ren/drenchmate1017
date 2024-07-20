import 'dart:io';
import 'package:device_apps/device_apps.dart';
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
import 'package:flutter_mailer/flutter_mailer.dart';

class ExportPage extends StatefulWidget {
  static String id = 'export_page';

  const ExportPage({super.key});

  @override
  _ExportPageState createState() => _ExportPageState();
}

class _ExportPageState extends State<ExportPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _email;

  // @override, initState - load user's email address from his user document

  @override
  Widget build(BuildContext context) {
    String userId = _auth.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,

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
    try {

      // create Excel file
      var excel = Excel.createExcel();
      Sheet sheetObject = excel['DrenchRecords'];

      // Add column headers
      sheetObject.appendRow([

        const TextCellValue('PropertyID'),
        const TextCellValue('PropertyAddress'),
        const TextCellValue('LivestockDescription'),
        const TextCellValue('PaddockID'),
        const TextCellValue('LivestockQty'),
        const TextCellValue('DrenchingDate'),
        const TextCellValue('MobNumber'),
        const TextCellValue('ChemicalID'),
        const TextCellValue('BatchNumber'),
        const TextCellValue('ExpirationDate'),
        const TextCellValue('DoseRate'),
        const TextCellValue('WithholdingPeriod'),
        const TextCellValue('ExportSlaughterInterval'),
        const TextCellValue('DateSafeForSlaughter'),
        const TextCellValue('AdverseReactions'),
        const TextCellValue('BrokenNeedleInAnimal'),
        const TextCellValue('EquipmentCleaned'),
        const TextCellValue('EquipmentCleanedBy'),
        const TextCellValue('ContactNo'),
        const TextCellValue('Comments'),

      ]);

      // Add drench record data
      sheetObject.appendRow([

        TextCellValue(recordData['PropertyID'].toString()),
        TextCellValue(recordData['PropertyAddress'].toString()),
        TextCellValue(recordData['LivestockDescription'].toString()),
        TextCellValue(recordData['PaddockID'].toString()),
        TextCellValue(recordData['LivestockQty'].toString()),
        TextCellValue(recordData['DrenchingDate'].toString()),
        TextCellValue(recordData['MobNumber'].toString()),
        TextCellValue(recordData['ChemicalID'].toString()),
        TextCellValue(recordData['BatchNumber'].toString()),
        TextCellValue(recordData['ExpirationDate'].toString()),
        TextCellValue(recordData['DoseRate'].toString()),
        TextCellValue(recordData['WithholdingPeriod'].toString()),
        TextCellValue(recordData['ExportSlaughterInterval'].toString()),
        TextCellValue(recordData['DateSafeForSlaughter'].toString()),
        TextCellValue(recordData['AdverseReactions'].toString()),
        TextCellValue(recordData['BrokenNeedleInAnimal'].toString()),
        TextCellValue(recordData['EquipmentCleaned'].toString()),
        TextCellValue(recordData['EquipmentCleanedBy'].toString()),
        TextCellValue(recordData['ContactNo'].toString()),
        TextCellValue(recordData['Comments'].toString()),

      ]);

      // Save Excel file
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/drench_record.xlsx';
      final file = File(path);
      file.writeAsBytesSync(excel.encode()!);

      // check if email client is available
      final bool canSendMail = await FlutterMailer.canSendMail();

      if (canSendMail) {
        final MailOptions mailOptions = MailOptions(
          body: 'Please find the attached drench record.',
          subject: 'Drench Record Export',
          recipients: [email],
          attachments: [path],
          isHTML: false,
        );

        await FlutterMailer.send(mailOptions);

        print('Drench record exported successfully');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Drench record exported successfully')),
        );

      } else {

        print('No email clients found on this device.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No email clients found on this device.')),
        );

      }

    } catch (e) {

      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to export drench record: $e')),
      );

    }
  }

}