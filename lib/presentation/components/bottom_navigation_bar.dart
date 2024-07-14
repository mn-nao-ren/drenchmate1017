import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drenchmate_2024/business_logic/state/navbar_state.dart';

class MyNavigationBar extends StatelessWidget {
  const MyNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavbarState>(
      builder: (context, navbarState, child) {
        return BottomNavigationBar(
          currentIndex: navbarState.selectedIndex,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey.shade600,
          onTap: (index) {
            navbarState.setIndex(index);
            _onItemTapped(context, index);
          },
          showUnselectedLabels: true,
          items: [
            _buildNavigationBarItem(
              context: context,
              index: 0,
              icon: Icons.dashboard,
              label: 'Home',
              color: Colors.blue.shade900,
              selectedColor: Colors.blue.shade900,
            ),
            _buildNavigationBarItem(
              context: context,
              index: 1,
              icon: Icons.notifications,
              label: 'Notices',
              color: Colors.black,
              selectedColor: Colors.black,
            ),
            _buildNavigationBarItem(
              context: context,
              index: 2,
              icon: Icons.person,
              label: 'Profile',
              color: Colors.red.shade900,
              selectedColor: Colors.red.shade800,
            ),
            _buildNavigationBarItem(
              context: context,
              index: 3,
              icon: Icons.file_upload,
              label: 'Export',
              color: Colors.green.shade900,
              selectedColor: Colors.green.shade800,
            ),
          ],
        );
      },
    );
  }

  BottomNavigationBarItem _buildNavigationBarItem({
    required BuildContext context,
    required int index,
    required IconData icon,
    required String label,
    required Color color,
    required Color selectedColor,
  }) {
    return BottomNavigationBarItem(
      label: label,
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Provider.of<NavbarState>(context, listen: false).selectedIndex == index ? selectedColor : color,
          ),
          const SizedBox(height: 2),
          if (Provider.of<NavbarState>(context, listen: false).selectedIndex == index)
            SizedBox(
              height: 7,
              width: 32,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: selectedColor,
                  borderRadius: BorderRadius.circular(55),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, 'dashboard_screen');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, 'notification_screen');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, 'create_profile_screen');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, 'generate_report_screen');
        break;
    }
  }
}
