import 'package:flutter/material.dart';
import 'package:drenchmate_2024/presentation/components/highlights_grid.dart';

import 'package:drenchmate_2024/presentation/components/dashboard_appbar.dart';
import 'package:drenchmate_2024/presentation/components/dashboard_header.dart';
import 'package:drenchmate_2024/presentation/components/header.dart';
import 'package:drenchmate_2024/presentation/components/shortcuts_grid.dart';

class DashboardView extends StatefulWidget {
  static String id = 'dashboard_page';
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => DashboardController();
}
class DashboardController extends State<DashboardView> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const DashboardAppbar(),
        body: ListView(
            children: [
              DashboardHeader(pageController: pageController),
              const SizedBox(height: 15),
              const Header(headerTitle: 'Highlights'),
              const SizedBox(height: 4),
              HighlightsGrid(),
              const SizedBox(height: 4),
              const Header(headerTitle: 'ShortCuts'),
              ShortcutsGrid(),

            ],
        ),
    );
  }
}