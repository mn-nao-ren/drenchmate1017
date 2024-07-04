import 'package:flutter/material.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _currentIndex = 0;

  List<Widget> body = const [
    Icon(Icons.person),
    Icon(Icons.home),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (int newIndex) {
        setState(() {
          _currentIndex = newIndex;
        });
      },
      items: const [
        BottomNavigationBarItem(
          label: 'Profile',
          icon: Icon(Icons.person),
        ),
        BottomNavigationBarItem(
          label: 'Drench Alert',
          icon: Icon(Icons.warning_amber_rounded),
        ),
        BottomNavigationBarItem(
          label: 'Activity',
          icon: Icon(Icons.local_activity_rounded),
        ),
      ]
    );
  }
}
