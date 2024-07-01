import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HighlightsGrid extends StatelessWidget {
  HighlightsGrid({super.key});

  final List<String> highlights = ['Mobs', 'Property', 'Drench'];
  final List<Color> colors =  [Colors.grey, Colors.lightBlue, Colors.blue];
  final List<Image> icons = [
    Image.asset('assets/icon/mob.png'),
    Image.asset('assets/icon/property.png'),
    Image.asset('assets/icon/drench.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GridView.builder(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3,
          crossAxisSpacing: 6,
          mainAxisSpacing: 5,
        ),

        itemBuilder: (context, index) {
          return Card(
            color: colors[index],
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  icons[index],
                  Text(
                    highlights[index],

                  )

                ]
              )
            )
          );
        },

      )
    );
  }
}