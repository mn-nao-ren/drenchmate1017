import 'package:flutter/material.dart';

class RecentDrench extends StatelessWidget {


  const RecentDrench({
    super.key,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(color: Colors.grey, width: 1.0),
        ),
        elevation: 4,
        color: Colors.lightBlue.shade50,
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'date and time of drench, which mob, mob name and mob number',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text('Comments field of the drench record'),
              )
            ],
          )
        )
      )

    );
  }
}