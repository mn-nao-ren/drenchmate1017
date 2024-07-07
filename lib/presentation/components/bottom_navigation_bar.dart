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

        backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey.shade600,

      onTap: (int newIndex) {
        setState(() {
          _currentIndex = newIndex;
        });
      },
      items: [
        BottomNavigationBarItem(
          label: 'Profile',
          icon: _currentIndex == 0
              ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.person),
              const SizedBox(height: 2),
              SizedBox(
                height: 5,
                width: 39,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade900,
                    borderRadius: BorderRadius.circular(55),
                  ),
                ),
              )
            ],
          )
              : const Icon(Icons.person),
        ),
        BottomNavigationBarItem(
          label: 'Drench Alert',
          icon: _currentIndex == 1
              ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.warning_amber_rounded),
              const SizedBox(height: 2),
              SizedBox(
                height: 5,
                width: 66,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.red.shade600,
                    borderRadius: BorderRadius.circular(55),
                  ),
                ),
              )
            ],
          )
              : const Icon(Icons.warning_amber_rounded),
        ),
        BottomNavigationBarItem(
          label: 'Activity',
          icon: _currentIndex == 2
              ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.work),
              const SizedBox(height: 2),
              SizedBox(
                height: 5,
                width: 42,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(55),
                  ),
                ),
              )
            ],
          )
              : const Icon(Icons.work),
        ),
      ]
    );
  }
}
