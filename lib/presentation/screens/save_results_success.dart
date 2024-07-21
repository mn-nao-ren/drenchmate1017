import 'package:drenchmate_2024/presentation/components/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';


class ResultsSavedPage extends StatelessWidget {
  static String id = 'results_saved';

  const ResultsSavedPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results Saved'),
        automaticallyImplyLeading: false,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Results saved successfully. Navigate back to Home screen on the bottom navigation bar (tap \'Home\' button on the bottom navigation bar).',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
      bottomNavigationBar: const MyNavigationBar(),
    );
  }
}


