import 'package:flutter/material.dart';

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
  /* class method */
  BottomNavigationBarItem _buildNavigationBarItem({
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
            color: widget.currentIndex == index ? selectedColor : color,
          ),
          const SizedBox(height: 2),
          if (widget.currentIndex == index)
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

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      onTap: widget.onItemTapped,
      showUnselectedLabels: true,
      items: [
        _buildNavigationBarItem(
          index: 0,
          icon: Icons.person_outlined,
          label: 'Profile',
          color: Colors.blue.shade900,
          selectedColor: Colors.blue.shade900,
        ),
        _buildNavigationBarItem(
          index: 1,
          icon: Icons.data_object_outlined,
          label: 'Export',
          color: Colors.black,
          selectedColor: Colors.black,
        ),
        _buildNavigationBarItem(
          index: 2,
          icon: Icons.warning_amber_outlined,
          label: 'Alerts',
          color: Colors.red.shade900,
          selectedColor: Colors.red.shade800,
        ),
        _buildNavigationBarItem(
          index: 3,
          icon: Icons.call_to_action_outlined,
          label: 'First Steps',
          color: Colors.blue,
          selectedColor: Colors.blue,
        ),
      ],
    );
  }
}
