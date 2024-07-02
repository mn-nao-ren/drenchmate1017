import 'package:flutter/material.dart';

class ShortcutsGrid extends StatelessWidget {
  ShortcutsGrid({super.key});

  final List<String> highlights = ['Mobs', 'Property', 'Drench'];
  final List<String> buttonText = ['Setup a Mob', 'Setup a Property', 'Setup a Drench'];
  final List<String> nextPage = [];
  final List<Color> colors =  [Colors.grey, Colors.lightBlue, Colors.blue];
  final List<Image> icons = [ /* place future button icons here */  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: GridView.builder(
          padding:  const EdgeInsets.symmetric(horizontal: 15),
          physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          itemBuilder: (context, index) {
            return const SizedBox(
              height: 206,
            );
          },


        )
    );
  }
}