import 'package:flutter/material.dart';

class AdvancedNotice extends StatelessWidget {
  final String mobName;
  final int paddockId;
  final int mobNumber;
  final String timestamp;
  final VoidCallback onAcknowledge;

  const AdvancedNotice({
    super.key,
    required this.mobName,
    required this.paddockId,
    required this.mobNumber,
    required this.timestamp,
    required this.onAcknowledge,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          tileColor: Colors.blue[50],
          title: const Text(
            "Advanced Notice",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: Text(
            "Mob: $mobName, Paddock: $paddockId, Mob Number: $mobNumber\nTime: $timestamp",
            style: const TextStyle(fontSize: 16),
          ),
          trailing: const Icon(Icons.info_outline, color: Colors.blue),
          onTap: () => _showDetailedMessage(context),
        ),
      ),
    );
  }

  void _showDetailedMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Drench Notice'),
          content: const Text(
              "DrenchMate is giving you advanced notice of when your last drench for this mob is no longer effective against parasites. DrenchMate recommends you drench the mob immediately, monitor mob health, and continue to schedule regular fecal egg count tests. DrenchMate will monitor all upcoming weather conditions for you. Consult your veterinarian if necessary."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                onAcknowledge();
                Navigator.of(context).pop();
              },
              child: const Text("Ok, noted. Do not keep repeating this notification to me."),
            ),
          ],
        );
      },
    );
  }
}
