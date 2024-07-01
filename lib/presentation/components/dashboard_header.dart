import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  final PageController pageController;
  const DashboardHeader({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: PageView.builder(
        controller: pageController,
        itemCount: 5,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(
              width: 285,
              height: double.infinity,
              child: Image.asset('assets/icon/icon.png'),
            )
          )
        ),
        pageSnapping: false,
          scrollBehavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.trackpad,
            }),
      )
    );
  }
}