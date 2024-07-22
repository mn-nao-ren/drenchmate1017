import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drenchmate_2024/presentation/components/bottom_navigation_bar.dart';
import 'package:excel/excel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:drenchmate_2024/presentation/components/username.dart';
import 'package:drenchmate_2024/business_logic/services/drench_record_list_svc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:device_info_plus/device_info_plus.dart';



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
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                    onPressed: _exportAllDrenchRecords,
                    child: const Text('Export All')
                ),
              ],

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

  Future<bool> checkPermissions() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        return await Permission.storage.request().isGranted;
      } else {
        // check for the READ_MEDIA_IMAGES permission
        return await Permission.photos.request().isGranted;
      }
    }
    return true;
  }

  void _exportDrenchRecord(Map<String, dynamic> recordData, String? email) async {
    if (email == null || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an email address')),
      );
      return;
    }

    try {
      bool hasPermissions = await checkPermissions();

      if (hasPermissions) {

        //create the excel file
        var excel = Excel.createExcel();

        // Remove default sheet if it exists
        String? defaultSheetName = excel.getDefaultSheet();
        //Rename the default sheet to 'DrenchRecord'
        excel.rename(defaultSheetName!, 'DrenchRecord');
        //Access the renamed sheet

        Sheet sheetObject = excel['DrenchRecord'];




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



        // Save Excel file to temporary directory
        final directory = await getTemporaryDirectory();
        final path = '${directory.path}/drench_record.xlsx';
        final file = File(path);
        file.writeAsBytesSync(excel.encode()!);

        final Email emailToSend = Email(
          body: 'Please find the attached drench record.',
          subject: 'Drench Record Export',
          recipients: [email],
          attachmentPaths: [path],
          isHTML: false,

        );

        await FlutterEmailSender.send(emailToSend);

        print('Drench record exported and emailed successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Drench record exported and emailed succesfully')),
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permission denied. Email not sent.')),
        );
        print('Permission denied. Email not sent.');
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to export drench record: $e')),
      );
    }
  }


  void _exportAllDrenchRecords() async {
    if (_email == null || _email!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an email address')),
      );
      return;
    }

    try {
      bool hasPermissions = await checkPermissions();

      if (hasPermissions) {
        var excel = Excel.createExcel();
        String? defaultSheetName = excel.getDefaultSheet();
        excel.rename(defaultSheetName!, 'Summary');
        Sheet summarySheet = excel['Summary'];
        String userId = _auth.currentUser!.uid;

        summarySheet.appendRow([
          const TextCellValue('Message'),
          const TextCellValue('Your_user_id'),
        ]);

        summarySheet.appendRow([
          const TextCellValue('Here are all of your drench records as you chose Export All'),
          TextCellValue(userId.toString()),
        ]);


        QuerySnapshot mobsSnapshot = await _firestore
            .collection('users')
            .doc(userId)
            .collection('mobs')
            .get();

        for (var mobDoc in mobsSnapshot.docs) {
          var mobData = mobDoc.data() as Map<String, dynamic>;
          String mobName = mobData['mobName'] ?? mobDoc.id;
          Sheet sheetObject = excel[mobName];
          // append column headers
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

          QuerySnapshot drenchesSnapshot = await _firestore
              .collection('users')
              .doc(userId)
              .collection('mobs')
              .doc(mobDoc.id)
              .collection('drenches')
              .get();

          for (var drenchDoc in drenchesSnapshot.docs) {
            var recordData = drenchDoc.data() as Map<String, dynamic>;
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
          }
        }

        final directory = await getTemporaryDirectory();
        final path = '${directory.path}/drench_records.xlsx';
        final file = File(path);
        file.writeAsBytesSync(excel.encode()!);

        final Email emailToSend = Email(
          body: 'Please find the attached drench records.',
          subject: 'Drench Records Export',
          recipients: [_email!],
          attachmentPaths: [path],
          isHTML: false,
        );

        await FlutterEmailSender.send(emailToSend);

        print('All drench records exported and emailed successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All drench records exported and emailed successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permission denied. Email not sent.')),
        );
        print('Permission denied. Email not sent.');
      }
    } catch(e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to export all drench records: $e')),
      );
    }
  }
}
