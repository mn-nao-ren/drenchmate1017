import 'package:flutter/material.dart';
import 'package:drenchmate_2024/presentation/screens/notification_screen.dart';

class MyNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onItemTapped;

  const MyNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
  });

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  BottomNavigationBarItem _buildNavigationBarItem({
    required int index,
    required IconData icon,
    required String label,
    required Color color,
    required Color selectedColor,
  }) {
    return BottomNavigationBarItem(
      label: label,
      icon: widget.currentIndex == index
          ? Column(
              mainAxisSize: MainAxisSize.min,
             children: [
               Icon(icon),
               const SizedBox(height: 2),
               SizedBox(
                 height: 7,
                 width: 32,
                 child: DecoratedBox(
                   decoration: BoxDecoration(
                     color: color,
                     borderRadius: BorderRadius.circular(55),
                   ),
                 ),
               ),
             ],
          )
          : Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      onTap: widget.onItemTapped,
      items: [
        _buildNavigationBarItem(
          index: 0,
          icon: Icons.person_outlined,
          label: 'Profile',
          color: Colors.blue.shade800,
          selectedColor: Colors.blue.shade800,
        ),
        _buildNavigationBarItem(
          index: 1,
          icon: Icons.notifications_outlined,
          label: 'Drench Alert',
          color: Colors.red.shade600,
          selectedColor: Colors.red.shade600,
        ),
        _buildNavigationBarItem(
          index: 2,
          icon: Icons.business_outlined,
          label: 'Alerts',
          color: Colors.blue,
          selectedColor: Colors.blue,
        ),
      ],
    );
  }
}
