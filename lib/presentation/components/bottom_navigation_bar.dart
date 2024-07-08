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

        backgroundColor: Colors.grey.shade300,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,

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
                width: 54,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.blue,
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
              const Icon(Icons.notifications),
              const SizedBox(height: 2),
              SizedBox(
                height: 5,
                width: 77,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.red.shade600,
                    borderRadius: BorderRadius.circular(55),
                  ),
                ),
              )
            ],
          )
              : const Icon(Icons.notifications),
        ),
        BottomNavigationBarItem(
          label: 'Activity',
          icon: _currentIndex == 2
              ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.add_business),
              const SizedBox(height: 2),
              SizedBox(
                height: 5,
                width: 56,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(55),
                  ),
                ),
              )
            ],
          )
              : const Icon(Icons.add_business),
        ),
      ]
    );
  }
}
